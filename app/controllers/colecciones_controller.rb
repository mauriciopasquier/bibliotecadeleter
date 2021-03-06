# encoding: utf-8
class ColeccionesController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad

  load_and_authorize_resource :usuario
  load_and_authorize_resource through: :usuario, singleton: true
  load_and_authorize_resource :version, only: [:update_slot]

  before_filter :determinar_galeria, only: [:show, :faltantes, :sobrantes]

  respond_to :json, only: [:update_slot]

  def show
    @versiones = PaginadorDecorator.decorate apply_scopes(@coleccion.versiones)

    @tipo_de_lista = 'colección'
    respond_with @coleccion
  end

  def edit
    respond_with @coleccion
  end

  def update_slot
    cargar_o_crear_slot.update_attribute(:cantidad, cantidad)
    @slot.destroy if @slot.cantidad == 0

    respond_to do |format|
      format.json { render json: @slot }
    end
  end

  def faltantes
    # autorizar también la reserva ya que usamos sus datos
    authorize! :read, @usuario.reserva

    @versiones = PaginadorDecorator.decorate(
      apply_scopes(
        Version.where(
          id: @usuario.faltantes.map(&:version_id)
        ).order('expansion_id desc').includes(:imagenes)
      )
    )

    @tipo_de_lista = 'faltantes'
    respond_with @coleccion, template: 'colecciones/show'
  end

  def sobrantes
    # autorizar también la reserva ya que usamos sus datos
    authorize! :read, @usuario.reserva

    @versiones = PaginadorDecorator.decorate(
      apply_scopes(
        Version.where(
          id: @usuario.sobrantes.map(&:version_id)
        ).order('expansion_id desc').includes(:imagenes)
      )
    )

    @tipo_de_lista = 'sobrantes'
    respond_with @coleccion, template: 'colecciones/show'
  end

  def update
    @coleccion.update coleccion_params

    respond_with @usuario, @coleccion, location: edit_usuario_coleccion_path(@usuario)
  end

  private

    def cargar_o_crear_slot
      @slot = @version.slot_en(@coleccion) || @coleccion.slots.build(version: @version)
    end

    def determinar_galeria
      tipo_actual params[:mostrar].try(:[], :tipo) || :mini
    end

    def coleccion_params
      params.require(:coleccion).permit(
        :nombre, :visible
      )
    end

    def cantidad
      params.require :cantidad
    end
end
