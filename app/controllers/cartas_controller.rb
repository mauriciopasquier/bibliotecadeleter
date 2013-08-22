# encoding: utf-8
class CartasController < ApplicationController
  autocomplete :carta, :nombre  # definido acá

  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' }

  ANONS = [ :autocomplete_carta_nombre ]

  load_and_authorize_resource except: ANONS
  skip_authorization_check only: ANONS

  before_filter :check_espia
  before_filter :decorar_carta, only: [:show, :edit]
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

  def edit
    respond_with(@carta)
  end

  def create
    @carta.save
    respond_with(@carta)
  end

  def update
    @carta.update_attributes(params[:carta])
    respond_with(@carta)
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
    end.decorate
  end

  # Redefinido para no pelear con rails3-jquery-autocomplete por el join
  def autocomplete_carta_nombre
    resultado = if (t = params[:term]).present?
      # TODO filtrar por expansión
      Carta.con_todo.where(
        Carta.arel_table[:nombre].matches("%#{params[:term]}%")
      )
    else
      modelo.none
    end.inject({}) do |hash, elem|
      # Hash de id: value
      hash[elem.nombre_y_expansion] = {
        label: elem.nombre_y_expansion,
        value: elem.nombre_y_expansion,
        version_id: elem.version_id
      }
      hash
    end

    render json: resultado
  end

  private

    def decorar_carta
      @carta = @carta.decorate
    end

    def preparar_consulta(q)
      if params[:incluir]
        query = q.delete busqueda
        q.merge! "#{params[:incluir].join('_or_')}_cont" => query
      end
      q
    end

    def check_barra_de_busqueda
      if params[:navbar].present? and params[:q][busqueda].empty?
        params[:q] = nil
      end
    end
end
