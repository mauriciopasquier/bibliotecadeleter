# encoding: utf-8
class CartasController < ApplicationController
  autocomplete :carta, :nombre  # definido acá

  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' }

  ANONS = [ :autocomplete_carta_nombre ]

  # TODO sacar cuando cancan contemple strong_parameters
  before_filter :cargar_recurso, only: :create
  load_and_authorize_resource except: ANONS
  skip_authorization_check only: ANONS

  before_filter :cargar_version, only: :show
  before_filter :check_espia
  before_filter :check_barra_de_busqueda, only: :buscar

  def index
    @busqueda = apply_scopes(@cartas.unscoped)
    @cartas = PaginadorDecorator.decorate @busqueda.result
    respond_with(@cartas)
  end

  def show
    respond_with(@carta)
  end

  def new
    respond_with(@carta)
  end

  def create
    @carta.save
    respond_with(@carta)
  end

  def update
    @carta.update_attributes(parametros_permitidos)
    respond_with(@carta, location: en_expansion_carta_path(@carta, expansion))
  end

  def destroy
    @carta.destroy
    respond_with(@carta)
  end

  def buscar
    @busqueda = Carta.search(params[:q])

    tipo_actual params[:mostrar].try(:[], :tipo) || :mini

    @cartas = if params[:q].present?
      @cartas
        .joins(:versiones)
        .select('cartas.*, versiones.senda')
        .order('versiones.senda')
        .search(preparar_consulta(params[:q])).result(distinct: true)
    else
      Carta.none
    end

    if @cartas.count == 1
      redirect_to @cartas.first
    else
      @cartas = @cartas.decorate
    end
  end

  # Redefinido para no pelear con rails3-jquery-autocomplete por el join
  def autocomplete_carta_nombre(restricciones = nil, metodo = nil)
    metodo ||= :nombre_y_expansion

    resultado = if (t = params[:term]).present?
      c = Carta.con_todo
      c = restricciones.present? ? c.where(restricciones) : c
      c.where(
        Carta.arel_table[:nombre].matches("%#{params[:term]}%")
      )
    else
      modelo.none
    end.inject({}) do |hash, elem|
      # Hash de id: value
      hash[elem.send(metodo)] = {
        label: elem.send(metodo),
        value: elem.send(metodo),
        version_id: elem.version_id
      }
      hash
    end

    render json: resultado
  end

  def autocompletar_canonicas
    autocomplete_carta_nombre(
      { versiones: { canonica: true } },
      :nombre_y_expansiones)
  end

  def autocompletar_demonios
    autocomplete_carta_nombre(versiones: { supertipo: 'Demonio' })
  end

  def autocompletar_sendas
    autocomplete_carta_nombre(versiones: {
      senda: [ params[:senda].capitalize, 'Neutral' ]
    })
  end

  private

    def preparar_consulta(q)
      if params[:incluir]
        query = q.delete view_context.busqueda
        q.merge! "#{params[:incluir].join('_or_')}_cont" => query
      end
      q
    end

    def check_barra_de_busqueda
      if params[:navbar].present? and params[:q][view_context.busqueda].empty?
        params[:q] = nil
      end
    end

    def cargar_version
      @version = if params[:expansion].present?
        @carta.versiones.where(expansion_id: expansion).first
      else
        @carta.canonica
      end
    end

    def expansion
      @expansion ||= begin
        Expansion.find(params[:expansion])
      rescue ActiveRecord::RecordNotFound
        Expansion.where(nombre: params[:expansion]).first || @carta.canonica.expansion
      end
    end

    def cargar_recurso
      @carta = Carta.new(parametros_permitidos)
    end

    def parametros_permitidos
      params.require(:carta).permit(
        :nombre,
        versiones_attributes: [
          :texto, :tipo, :supertipo, :subtipo, :fue, :res, :senda,
          :ambientacion, :numero, :rareza, :coste, :id, :_destroy,
          :expansion_id, imagenes_attributes: [
            :arte, :archivo
          ]
        ]
      )
    end
end
