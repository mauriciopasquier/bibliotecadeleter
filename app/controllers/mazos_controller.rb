# encoding: utf-8
class MazosController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' }, only: :index

  # TODO sacar cuando cancan contemple strong_parameters
  before_filter :cargar_recurso, only: :create
  load_and_authorize_resource :usuario
  load_and_authorize_resource through: :usuario, except: :index

  respond_to :ficha, only: :show

  def index
    @mazos = @usuario.mazos.accessible_by(current_ability)
    @busqueda = apply_scopes @mazos
    @mazos = PaginadorDecorator.decorate @busqueda.result

    respond_with(@mazos)
  end

  def show
    respond_with(@usuario, @mazo)
  end

  def new
    respond_with(@usuario, @mazo)
  end

  def edit
    respond_with(@usuario, @mazo)
  end

  def create
    @mazo.usuario = @usuario
    @mazo.save
    respond_with(@usuario, @mazo)
  end

  def update
    @mazo.update_attributes(parametros_permitidos)
    respond_with(@usuario, @mazo)
  end

  def destroy
    @mazo.destroy
    respond_with(@usuario, @mazo)
  end


  private

    def cargar_recurso
      @mazo = Mazo.new(parametros_permitidos)
    end

    def parametros_permitidos
      params.require(:mazo).permit(
        :nombre, :formato_objetivo_id, :visible, :exigir_formato,
        slots_attributes: [
          :id, :_destroy, :cantidad, :version_id
        ],
        principal_attributes: [
          :id, :_destroy,
          slots_attributes: [
            :id, :_destroy, :cantidad, :version_id
          ]
        ],
        suplente_attributes: [
          :id, :_destroy,
          slots_attributes: [
            :id, :_destroy, :cantidad, :version_id
          ]
        ]
      )
    end
end
