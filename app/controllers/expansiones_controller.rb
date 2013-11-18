# encoding: utf-8
class ExpansionesController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' }, only: :index

  # TODO sacar cuando cancan contemple strong_parameters
  before_filter :cargar_recurso, only: :create
  load_and_authorize_resource

  def index
    @busqueda = apply_scopes @expansiones
    @expansiones = PaginadorDecorator.decorate @busqueda.result

    respond_with(@expansiones)
  end

  def show
    @versiones = PaginadorDecorator.decorate apply_scopes(@expansion.versiones)
    tipo_actual params[:mostrar].try(:[], :tipo) || :mini

    respond_with(@expansion)
  end

  def sobre
    @versiones = Draper::CollectionDecorator.decorate @expansion.abrir_sobre
    tipo_actual params[:mostrar].try(:[], :tipo) || :mini

    respond_with(@expansion)
  end

  def info
    respond_with(@expansion)
  end

  def new
    respond_with(@expansion)
  end

  def edit
    respond_with(@expansion)
  end

  def create
    @expansion.save
    respond_with(@expansion, location: info_expansion_path(@expansion))
  end

  def update
    @expansion.update_attributes(parametros_permitidos)
    respond_with(@expansion, location: info_expansion_path(@expansion))
  end

  def destroy
    @expansion.destroy
    respond_with(@expansion)
  end

  private

    def cargar_recurso
      @expansion = Expansion.new(parametros_permitidos)
    end

    def parametros_permitidos
      params.require(:expansion).permit(
        :nombre, :lanzamiento, :presentacion, :saga, :total, :notas, :logo,
        formato_ids: []
      )
    end
end
