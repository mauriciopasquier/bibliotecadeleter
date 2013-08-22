# encoding: utf-8
class ListasController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' }, only: :index

  load_and_authorize_resource :usuario, except: [:coleccion]
  load_and_authorize_resource through: :usuario, except: [:coleccion]

  before_filter :determinar_galeria, only: [:show]

  def index
    @busqueda = apply_scopes(@listas.unscoped.normales)
    @listas = PaginadorDecorator.decorate @busqueda.result

    respond_with(@listas)
  end

  def show
    @versiones = PaginadorDecorator.decorate apply_scopes(@lista.versiones)
    respond_with(@usuario, @lista)
  end

  def new
    respond_with(current_usuario, @lista)
  end

  def edit
    respond_with(current_usuario, @lista)
  end

  def create
    @lista.save
    respond_with(current_usuario, @lista)
  end

  def update
    @lista.update_attributes(params[:lista])
    respond_with(current_usuario, @lista)
  end

  def destroy
    @lista.destroy
    respond_with(current_usuario, @lista)
  end

  def coleccion
    @usuario = current_usuario
    @lista = @usuario.coleccion
    authorize! :read, @lista
    respond_with(@usuario, @lista)
  end

  private

    def determinar_galeria
      tipo_actual params[:mostrar].try(:[], :tipo) || :original
    end
end
