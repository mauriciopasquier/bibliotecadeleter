# encoding: utf-8
class ArtistasController < ApplicationController

  load_and_authorize_resource

  def index
    @artistas = @artistas.decorate
    @titulo = 'Artistas'
    respond_with(@artistas)
  end

  def show
    @artista = @artista.decorate
    @titulo = @artista.nombre
    respond_with(@artista)
  end

  def new
    @artista = @artista.decorate
    @titulo = @artista.nombre
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
