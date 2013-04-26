# encoding: utf-8
class ExpansionesController < ApplicationController
  autocomplete :expansion, :nombre, full: true

  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' }, only: :index

  ANONS = [ :autocomplete_expansion_nombre ]

  load_and_authorize_resource except: ANONS
  skip_authorization_check only: ANONS

  before_filter :decorar_expansion, only: [:show, :edit]

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
    @expansion.update_attributes(params[:expansion])
    respond_with(@expansion)
  end

  def destroy
    @expansion.destroy
    respond_with(@expansion)
  end

  private

    def decorar_expansion
      @expansion = @expansion.decorate
    end
end
