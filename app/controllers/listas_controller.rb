# encoding: utf-8
class ListasController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' }, only: :index

  load_and_authorize_resource :usuario
  load_and_authorize_resource through: :usuario

  before_filter :decorar_lista, only: [:show, :edit]

  def index
    @busqueda = apply_scopes(@listas.unscoped)
    @listas = PaginadorDecorator.decorate @busqueda.result

    respond_with(@listas)
  end

  def show
    respond_with(@lista = @lista.decorate)
  end

  def new
    respond_with(@lista)
  end

  def edit
    respond_with(@lista)
  end

  def create
    @lista.save
    respond_with(@lista)
  end

  def update
    @lista.update_attributes(params[:lista])
    respond_with(@lista)
  end

  def destroy
    @lista.destroy
    respond_with(@lista)
  end

  def coleccion
    @lista = current_usuario.coleccion
    respond_with @lista = @lista.decorate
  end

  private

    def decorar_lista
      @lista = @lista.decorate
    end
end
