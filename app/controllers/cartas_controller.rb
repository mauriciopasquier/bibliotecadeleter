# encoding: utf-8
class CartasController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' }

  load_and_authorize_resource

  before_filter :cargar_version, only: :show
  before_filter :check_espia
  before_filter :check_barra_de_busqueda, only: :buscar

  def index
    # FIXME hasta rails 4.1 except o unscope todavía no sacan el default_scope
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
    # Cargamos la versión que estamos intentando crear por si hay error,
    # asumiendo que sólo se envía una versión a la vez
    @version = Version.new carta_params[:versiones_attributes].values.first

    @carta.update carta_params
    respond_with(@carta, location: en_expansion_carta_path(@carta, expansion))
  end

  def destroy
    @carta.destroy
    respond_with(@carta)
  end

  def buscar
    @busqueda = Carta.search

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

      if params[:formato]
        exp = :versiones_expansion_id_eq_any
        params[:q][exp] = (params[:formato].collect do |exps|
          exps.split(', ')
        end + Array.wrap(params[:q][exp])).flatten.uniq
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

    def carta_params
      params.require(:carta).permit(
        :nombre,
        versiones_attributes: [
          :texto, :tipo, :supertipo, :subtipo, :fue, :res, :senda,
          :ambientacion, :numero, :rareza, :coste, :id, :_destroy,
          :expansion_id, imagenes_attributes: [
            :arte, :archivo, :cara, :id
          ]
        ]
      )
    end
end
