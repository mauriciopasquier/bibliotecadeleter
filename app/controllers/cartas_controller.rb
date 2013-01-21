# encoding: utf-8
class CartasController < ApplicationController

  load_and_authorize_resource

  before_filter :decorar, only: [:index, :show, :edit]

  helper_method :busqueda, :versiones_tipos

  def index
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
      if @cartas
        @cartas = @cartas.decorate
      else
        @carta = @carta.decorate
      end
    end

    def preparar_consulta(q)
      query = q.delete busqueda
      q.merge "#{params[:incluir].join('_or_')}_cont" => query
    end

    def busqueda
      [versiones_tipos, 'versiones_texto', 'nombre'].join('_or_') + '_cont'
    end

    def versiones_tipos
      ['versiones_tipo', 'versiones_supertipo', 'versiones_subtipo'].join('_or_')
    end

end
