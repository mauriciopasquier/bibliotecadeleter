# encoding: utf-8
class ReservasController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad

  load_and_authorize_resource through: :current_usuario, singleton: true
  load_and_authorize_resource :version, only: [:update]

  respond_to :json, only: [:update]

  def show
    @versiones = PaginadorDecorator.decorate apply_scopes(@reserva.versiones)
    tipo_actual params[:mostrar].try(:[], :tipo) || :original

    respond_with(@reserva)
  end

  def edit
    respond_with(@reserva)
  end

  def update
    cargar_o_crear_slot.update_attribute(:cantidad, params[:cantidad])
    respond_to do |format|
      format.json { render json: @slot }
    end
  end

  private

    def cargar_o_crear_slot
      @slot = @version.slot_en(@reserva) || @reserva.slots.build(version: @version)
    end
end
