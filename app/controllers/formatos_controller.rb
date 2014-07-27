# encoding: utf-8
class FormatosController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'tipo asc' }, only: :index

  load_and_authorize_resource

  def index
    @busqueda = apply_scopes @formatos
    @formatos = PaginadorDecorator.decorate @busqueda.result

    respond_with @formatos
  end

  def show
    respond_with(@formato)
  end

  def new
    respond_with(@formato)
  end

  def edit
    respond_with(@formato)
  end

  def create
    @formato.save
    respond_with(@formato)
  end

  def update
    @formato.update formato_params
    respond_with(@formato)
  end

  def destroy
    @formato.destroy
    respond_with(@formato)
  end

  private

    def formato_params
      params.require(:formato).permit(
        :nombre, :nombres_de_cartas_prohibidas, { expansion_ids: [] },
        :limitar_sendas, :suplente, :principal, :demonios, :copias, :tipo
      )
    end
end
