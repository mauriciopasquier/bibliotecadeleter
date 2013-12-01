# encoding: utf-8
class ReservasController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad

  load_and_authorize_resource :usuario
  load_and_authorize_resource through: :usuario, singleton: true
  load_and_authorize_resource :version, only: [:update_slot]

  before_filter :determinar_galeria, only: [:show]

  respond_to :json, only: [:update_slot]

  def show
    @versiones = PaginadorDecorator.decorate apply_scopes(@reserva.versiones)

    @tipo_de_lista = 'reserva'
    respond_with @reserva, template: 'colecciones/show'
  end

  def update_slot
    cargar_o_crear_slot.update_attribute(:cantidad, cantidad)

    respond_to do |format|
      format.json { render json: @slot }
    end
  end

  def update
    @reserva.update parametros_permitidos

    respond_with @usuario, @reserva, location: edit_usuario_coleccion_path(@usuario)
  end

  private

    def cargar_o_crear_slot
      @slot = @version.slot_en(@reserva) || @reserva.slots.build(version: @version)
    end

    def determinar_galeria
      tipo_actual params[:mostrar].try(:[], :tipo) || :mini
    end

    def parametros_permitidos
      params.require(:reserva).permit(
        :nombre, :visible
      )
    end

    def cantidad
      params.require :cantidad
    end
end
