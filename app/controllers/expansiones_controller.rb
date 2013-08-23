# encoding: utf-8
require "yaml"

class ExpansionesController < ApplicationController
  autocomplete :expansion, :nombre, full: true
  autocompletar_columnas :saga

  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' }, only: :index

  ANONS = [ :autocomplete_expansion_nombre, :completar_saga ]

  load_and_authorize_resource except: ANONS
  skip_authorization_check only: ANONS

  before_filter :parsear_notas, only: [:create, :update]

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

    # TODO averiguar la inseguridad de Psych
    def parsear_notas
      @expansion.notas = YAML.load(@expansion.notas).with_indifferent_access
    end
end
