# encoding: utf-8
class ArtistasController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad

  load_and_authorize_resource

  # En vez de has_scope porque no puedo usar un atributo virtual con Ransack
  before_filter :ordenar, only: :index

  def index
    @artistas = apply_scopes(@artistas).con_ilustraciones.con_cantidad

    @titulo = 'Todos los Artistas'

    respond_with(@artistas)
  end

  def show
    @artista = @artista.decorate
    @ilustraciones = apply_scopes(@artista.ilustraciones).decorate
    @titulo = @artista.nombre

    tipo_actual params[:mostrar].try(:[], :tipo) || :arte

    respond_with(@artista)
  end

  def new
    @artista = @artista.decorate
    @titulo = "Nueva artista"
    respond_with(@artista)
  end

  def edit
    @artista = @artista.decorate
    @titulo = @artista.nombre
  end

  def create
    @artista.save
    @artista = @artista.decorate
    respond_with(@artista)
  end

  def update
    @artista.update_attributes(params[:artista])
    @artista = @artista.decorate
    respond_with(@artista)
  end

  def destroy
    @artista.destroy
    @artista = @artista.decorate
    respond_with(@artista)
  end

  private

    def ordenar
      # TODO hacer esto más lindo
      if params[:q].present?
        @artistas = @artistas.reorder(params[:q][:s])
      end
      @busqueda = Artista.search(params[:q])
    end

end
