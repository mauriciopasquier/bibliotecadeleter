# encoding: utf-8
class ColeccionesController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad

  load_and_authorize_resource through: :current_usuario, singleton: true
  load_and_authorize_resource :version, only: [:update]

  before_filter :determinar_galeria, only: [:show, :faltantes, :sobrantes]

  respond_to :json, only: [:update]

  def show
    @versiones = PaginadorDecorator.decorate apply_scopes(@coleccion.versiones)

    @tipo_de_lista = 'colección'
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

  def faltantes
    @versiones = PaginadorDecorator.decorate(
      apply_scopes(
        Version.where(
          id: current_usuario.faltantes.map(&:version_id)
        ).order('expansion_id desc').includes(:imagenes)
      )
    )

    respond_with(@coleccion, template: 'colecciones/show')
  end

  def sobrantes
    @versiones = PaginadorDecorator.decorate(
      apply_scopes(
        Version.where(
          id: current_usuario.sobrantes.map(&:version_id)
        ).order('expansion_id desc').includes(:imagenes)
      )
    )

    respond_with(@coleccion, template: 'colecciones/show')
  end

  private

    def cargar_o_crear_slot
      @slot = @version.slot_en(@coleccion) || @coleccion.slots.build(version: @version)
    end

    def determinar_galeria
      tipo_actual params[:mostrar].try(:[], :tipo) || :mini
    end
end
