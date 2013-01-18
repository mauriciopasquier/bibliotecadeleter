# encoding: utf-8
class ArtistasController < ApplicationController
  has_scope :pagina, default: 1

  load_and_authorize_resource

  def index
    @artistas = apply_scopes(Artista).con_ilustraciones.con_cantidad.decorate
    @titulo = 'Todos los Artistas'
    respond_with(@artistas) do |format|
      # TODO Esta es la mejor forma de usar ajax + kaminari? Tal vez un responder
      format.html do
        if request.xhr?   # solicitud ajax para la paginación
          render :index,  layout: false
        end
      end
    end
  end

  def show
    @artista = @artista.decorate
    @imagenes = @artista.galeria(params[:pagina_galeria])
    @titulo = @artista.nombre
    respond_with(@artista) do |format|
      format.html do
        if request.xhr?   # solicitud ajax para la paginación
          render  partial: 'layouts/galeria',
                  locals: {
                    imagenes: @imagenes,
                    paginar: true
                  }
        end
      end
    end

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
end
