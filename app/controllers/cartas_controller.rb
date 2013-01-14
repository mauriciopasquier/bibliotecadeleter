# encoding: utf-8
class CartasController < ApplicationController

  load_and_authorize_resource

  def index
    @titulo = 'Cartas'
    respond_with(@cartas)
  end

  def show
    @titulo = @carta.nombre
    respond_with(@carta)
  end

  def new
    @titulo = @carta.nombre
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
        .search(params[:q]).result(distinct: true)
    else
      Carta.none
    end.decorate
  end
end
