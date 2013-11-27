# encoding: utf-8
class DisenosController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' }

  # TODO sacar cuando cancan contemple strong_parameters
  before_filter :cargar_recurso, only: :create
  load_and_authorize_resource :usuario
  load_and_authorize_resource through: :usuario, except: :index

  def index
    @disenos = @usuario.disenos.accessible_by(current_ability)
    @busqueda = apply_scopes @disenos
    @disenos = PaginadorDecorator.decorate @busqueda.result

    respond_with(@disenos)
  end

  def show
    respond_with(@usuario, @diseno)
  end

  def new
    respond_with(@usuario, @diseno)
  end

  def edit
    respond_with(@usuario, @diseno)
  end

  def create
    @diseno.usuario = @usuario
    @diseno.save
    respond_with(@usuario, @diseno)
  end

  def update
    @diseno.update parametros_permitidos
    respond_with(@usuario, @diseno)
  end

  def destroy
    @diseno.destroy
    respond_with(@usuario, @diseno)
  end

  private

    def cargar_recurso
      @diseno = Diseno.new(parametros_permitidos)
    end

    def parametros_permitidos
      params.require(:diseno).permit(
        :nombre, :texto, :tipo, :supertipo, :subtipo, :fue, :res, :senda,
        :ambientacion, :coste, :id, :_destroy, :fundamento
      )
    end
end
