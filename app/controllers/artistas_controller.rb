# encoding: utf-8
class ArtistasController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad

  load_and_authorize_resource

  before_filter :decorar_artista, only: [:show, :edit]
  # En vez de has_scope porque no puedo usar un atributo virtual con Ransack
  before_filter :ordenar, only: :index

  def index
    @artistas = apply_scopes(@artistas).con_ilustraciones.con_cantidad

    respond_with(@artistas)
  end

  def show
    @ilustraciones = PaginadorDecorator.decorate apply_scopes(@artista.ilustraciones)
    tipo_actual params[:mostrar].try(:[], :tipo) || :arte

    respond_with(@artista)
  end

  def new
    respond_with(@artista)
  end

  def edit
    respond_with(@artista)
  end

  def create
    @artista.save
    respond_with(@artista)
  end

  def update
    @artista.update_attributes(params[:artista])
    respond_with(@artista)
  end

  def destroy
    @artista.destroy
    respond_with(@artista)
  end

  private

    def decorar_artista
      @artista = @artista.decorate
    end

    def ordenar
      # TODO hacer esto más lindo
      if params[:q].present?
        @artistas = @artistas.reorder(params[:q][:s])
      end
      @busqueda = Artista.search(params[:q])
    end

end
