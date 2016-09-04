# encoding: utf-8
class ListasController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' },
    only: [:index, :todo]

  load_and_authorize_resource :usuario, except: :todo
  load_and_authorize_resource through: :usuario, except: [:index, :todo]
  authorize_resource only: [:todo]
  load_and_authorize_resource :version, only: [:update_slot]

  before_filter :determinar_galeria, only: [:show]

  respond_to :json, only: [:update_slot]

  def index
    @listas = @usuario.listas.normales.accessible_by(current_ability)
    @busqueda = apply_scopes @listas
    @listas = PaginadorDecorator.decorate @busqueda.result

    respond_with(@listas)
  end

  def todo
    @listas = Lista.normales.accessible_by(current_ability)
    @busqueda = apply_scopes @listas
    @listas = PaginadorDecorator.decorate @busqueda.result

    respond_with @listas, template: 'listas/index'
  end

  def show
    @versiones = PaginadorDecorator.decorate apply_scopes(@lista.versiones)
    respond_with(@usuario, @lista)
  end

  def new
    respond_with(@usuario, @lista)
  end

  def edit
    respond_with(@usuario, @lista)
  end

  def create
    @lista.usuario = current_usuario
    @lista.save
    respond_with(@usuario, @lista)
  end

  def update
    @lista.update lista_params
    respond_with(@usuario, @lista)
  end

  def update_slot
    cargar_o_crear_slot.update_attribute :cantidad, cantidad
    @slot.destroy if @slot.cantidad == 0

    respond_to do |format|
      format.json { render json: @slot }
    end
  end

  def destroy
    @lista.destroy
    respond_with(@usuario, @lista)
  end

  private

    def determinar_galeria
      tipo_actual params[:mostrar].try(:[], :tipo) || :original
    end

    def lista_params
      params.require(:lista).permit(
        :nombre, :visible, :notas,
        slots_attributes: [
          :id, :_destroy, :cantidad, :version_id
        ]
      )
    end

    def cargar_o_crear_slot
      @slot = @version.slot_en(@lista) || @lista.slots.build(version: @version)
    end

    def cantidad
      params.require :cantidad
    end
end
