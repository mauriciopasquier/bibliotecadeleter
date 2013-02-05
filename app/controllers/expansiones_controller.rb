# encoding: utf-8
class ExpansionesController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad
  has_scope :search, as: :q, type: :hash, default: { s: 'nombre asc' }, only: :index

  load_and_authorize_resource

  before_filter :mostrar, only: [:index, :show]

  def index
    @busqueda = apply_scopes(@expansiones.unscoped)
    @expansiones = @busqueda.result.decorate
    @titulo = 'Todas las Expansiones'

    respond_with(@expansiones)
  end

  def show
    @expansion = @expansion.decorate
    @imagenes = apply_scopes(@expansion.versiones).decorate
    @titulo = @expansion.nombre

    tipo_actual params[:mostrar].try(:[], :tipo) || :mini

    respond_with(@expansion)
  end

  def new
    @expansion = @expansion.decorate
    @titulo = "Nueva expansión"
    respond_with(@expansion)
  end

  def edit
    @expansion = @expansion.decorate
    @titulo = @expansion.nombre
  end

  def create
    @expansion.save
    @expansion = @expansion.decorate
    respond_with(@expansion)
  end

  def update
    @expansion.update_attributes(params[:expansion])
    @expansion = @expansion.decorate
    respond_with(@expansion)
  end

  def destroy
    @expansion.destroy
    @expansion = @expansion.decorate
    respond_with(@expansion)
  end

  private

    def mostrar
      if params[:mostrar].present?
        if params[:mostrar][:cantidad] =~ /todo/i
          params[:mostrar][:cantidad] = case params[:action]
            when 'show'
              @expansion.versiones.count.to_s
            when 'index'
              @expansiones.count.to_s
            else
              # Nada
          end
          params[:pagina] = '1'
        end
      end
    end
end
