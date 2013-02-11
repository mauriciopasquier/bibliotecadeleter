# encoding: utf-8
class CartasController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' }

  load_and_authorize_resource

  before_filter :check_espia
  before_filter :decorar, only: [:show, :edit]
  before_filter :check_barra_de_busqueda, only: :buscar

  def index
    @busqueda = apply_scopes(@cartas.unscoped)
    @cartas = @busqueda.result.decorate
    @titulo = 'Todas las cartas'
    respond_with(@cartas)
  end

  def show
    @titulo = @carta.nombre
    respond_with(@carta)
  end

  def new
    @titulo = "Nueva carta"
    respond_with(@carta)
  end

  def edit
    @titulo = @carta.nombre
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
    @titulo = 'Búsqueda de cartas'

    tipo_actual params[:mostrar].try(:[], :tipo) || :original

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

  private

    def decorar
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
