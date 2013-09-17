# encoding: utf-8
class ExpansionesController < ApplicationController
  autocomplete :expansion, :nombre, full: true
  autocompletar_columnas :saga

  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' }, only: :index

  ANONS = [ :autocomplete_expansion_nombre, :completar_saga ]

  # TODO sacar cuando cancan contemple strong_parameters
  before_filter :cargar_recurso, only: :create
  load_and_authorize_resource except: ANONS
  skip_authorization_check only: ANONS

  def index
    @busqueda = apply_scopes(@expansiones.unscoped)
    @expansiones = PaginadorDecorator.decorate @busqueda.result

    respond_with(@expansiones)
  end

  def show
    @versiones = PaginadorDecorator.decorate apply_scopes(@expansion.versiones)
    tipo_actual params[:mostrar].try(:[], :tipo) || :mini

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
    respond_with(@expansion)
  end

  def update
    @expansion.update_attributes(parametros_permitidos)
    respond_with(@expansion)
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
        :nombre, :lanzamiento, :presentacion, :saga, :total, :notas
      )
    end
end
