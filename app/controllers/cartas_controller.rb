# encoding: utf-8
class CartasController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' }

  # TODO sacar cuando cancan contemple strong_parameters
  before_filter :cargar_recurso, only: :create
  load_and_authorize_resource

  before_filter :cargar_version, only: :show
  before_filter :check_espia
  before_filter :check_barra_de_busqueda, only: :buscar

  def index
    # TODO con rails 4 sacar sólo el order
    @busqueda = apply_scopes @cartas.reorder('')
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
