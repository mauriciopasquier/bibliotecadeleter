# encoding: utf-8
class FormatosController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' }, only: :index

  # TODO sacar cuando cancan contemple strong_parameters
  before_filter :cargar_recurso, only: :create
  load_and_authorize_resource

  def index
    @busqueda = apply_scopes @formatos
    @formatos = PaginadorDecorator.decorate @busqueda.result

    respond_with @formatos
  end

  def show
    respond_with(@formato)
  end

  def new
    respond_with(@formato)
  end

  def edit
    respond_with(@formato)
  end

  def create
    @formato.save
    respond_with(@formato)
  end

  def update
    @formato.update_attributes(parametros_permitidos)
    respond_with(@formato)
  end

  def destroy
    @formato.destroy
    respond_with(@formato)
  end

  private

    def cargar_recurso
      @formato = Formato.new(parametros_permitidos)
    end

    def parametros_permitidos
      params.require(:formato).permit(
        :nombre
      )
    end
end
