# encoding: utf-8
class MazosController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' }, only: :index

  load_and_authorize_resource :usuario
  load_and_authorize_resource through: :usuario

  before_filter :determinar_galeria, only: [:show]

  def index
    @busqueda = apply_scopes(@mazos.unscoped)
    @mazos = PaginadorDecorator.decorate @busqueda.result

    respond_with(@mazos)
  end

  def show
    @versiones = PaginadorDecorator.decorate apply_scopes(@mazo.versiones)
    respond_with(@usuario, @mazo)
  end

  def new
    respond_with(@usuario, @mazo)
  end

  def edit
    respond_with(@usuario, @mazo)
  end

  def create
    @mazo.save
    respond_with(@usuario, @mazo)
  end

  def update
    @mazo.update_attributes(params[:mazo])
    respond_with(@usuario, @mazo)
  end

  def destroy
    @mazo.destroy
    respond_with(@usuario, @mazo)
  end


  private

    def determinar_galeria
      tipo_actual params[:mostrar].try(:[], :tipo) || :original
    end
end
