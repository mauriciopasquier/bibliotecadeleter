# encoding: utf-8
class ArtistasController < ApplicationController

  load_and_authorize_resource

  def index
    @titulo = 'Artistas'
    respond_with(@artistas)
  end

  def show
    @titulo = @artista.nombre
    respond_with(@artista)
  end

  def new
    @titulo = @artista.nombre
    respond_with(@artista)
  end

  def edit
    @titulo = @artista.nombre
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
end
