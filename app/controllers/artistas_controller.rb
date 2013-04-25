# encoding: utf-8
class ArtistasController < ApplicationController
  autocomplete :artista, :nombre, full: true

  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad

  ANONS = [ :autocomplete_artista_nombre ]

  load_and_authorize_resource except: ANONS
  skip_authorization_check only: ANONS

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
