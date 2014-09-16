# encoding: utf-8
class TiendasController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'tipo asc' }, only: :index

  load_and_authorize_resource

  def index
    @busqueda = apply_scopes @tiendas
    @tiendas = PaginadorDecorator.decorate @busqueda.result

    respond_with @tiendas
  end

  def show
    respond_with @tienda
  end

  def new
    respond_with @tienda
  end

  def edit
    respond_with @tienda
  end

  def create
    @tienda.save
    respond_with @tienda
  end

  def update
    @tienda.update tienda_params
    respond_with @tienda
  end

  def destroy
    @tienda.destroy
    respond_with @tienda
  end

  private

    def tienda_params
      params.require(:tienda).permit(
        :nombre, :region, :direccion,
        links_attributes: [
          :nombre, :url, :id
        ]
      )
    end
end
