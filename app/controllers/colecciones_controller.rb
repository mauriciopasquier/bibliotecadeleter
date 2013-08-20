# encoding: utf-8
class ColeccionesController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad

  load_and_authorize_resource through: :current_usuario, singleton: true
  load_and_authorize_resource :version, only: [:update]

  respond_to :json, only: [:update]

  def show
    @versiones = PaginadorDecorator.decorate apply_scopes(@coleccion.versiones)
    tipo_actual params[:mostrar].try(:[], :tipo) || :original

    respond_with(@coleccion)
  end

  def edit
    respond_with(@coleccion)
  end

  def update
    cargar_o_crear_slot.update_attribute(:cantidad, params[:cantidad])
    respond_to do |format|
      format.json { render json: @slot }
    end
  end

  private

    def cargar_o_crear_slot
      @slot = @version.slot_en(@coleccion) || @coleccion.slots.build(version: @version)
    end
end
