# encoding: utf-8
class MazosController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' },
    only: [ :index, :todo ]

  load_and_authorize_resource :usuario, except: :todo
  load_and_authorize_resource through: :usuario, except: [:index, :todo]
  authorize_resource only: [:todo]
  skip_authorize_resource only: :copiar

  respond_to :ficha, only: :show

  def index
    @mazos = @usuario.mazos.accessible_by(current_ability)
    @busqueda = apply_scopes @mazos
    @mazos = PaginadorDecorator.decorate @busqueda.result

    respond_with @mazos
  end

  def todo
    @mazos = Mazo.accessible_by(current_ability)
    @busqueda = apply_scopes @mazos
    @mazos = PaginadorDecorator.decorate @busqueda.result

    respond_with @mazos, template: 'mazos/index'
  end

  def show
    respond_with @usuario, @mazo
  end

  def new
    respond_with @usuario, @mazo
  end

  def edit
    respond_with @usuario, @mazo
  end

  def create
    @mazo.usuario = @usuario
    @mazo.save
    respond_with @usuario, @mazo
  end

  def update
    @mazo.update mazo_params
    respond_with @usuario, @mazo
  end

  def destroy
    @mazo.destroy
    respond_with @usuario, @mazo
  end

  def copiar
    @usuario = current_usuario
    @mazo = @mazo.amoeba_dup
    respond_with @usuario, @mazo, template: 'mazos/new'
  end

  private

    def mazo_params
      params.require(:mazo).permit(
        :nombre, :formato_objetivo_id, :visible, :exigir_formato, :notas,
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
