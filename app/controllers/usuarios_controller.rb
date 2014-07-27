class UsuariosController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nick asc' }

  load_and_authorize_resource

  def index
    @busqueda = apply_scopes @usuarios
    @usuarios = PaginadorDecorator.decorate @busqueda.result
    respond_with(@usuarios)
  end

  def show
    respond_with(@usuario)
  end

  def panel
    respond_with(@usuario)
  end

  def carnet
    respond_with(@usuario)
  end

  def update
    @usuario.update usuario_params
    respond_with(@usuario)
  end

  private

    def usuario_params
      params.require(:usuario).permit(
        :avatar
      )
    end
end
