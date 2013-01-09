# encoding: utf-8
class VersionesController < ApplicationController

  load_and_authorize_resource :carta
  load_and_authorize_resource through: :carta

  def index
    @titulo = "Versiones de #{@carta.nombre}"
    respond_with(@carta, @versiones)
  end

  def show
    @titulo = "#{@carta.nombre} de #{@version.expansion.nombre}"
    respond_with(@carta, @version)
  end

  def new
    @titulo = "Nueva carta"
    respond_with(@carta, @version)
  end

  def edit
    @titulo = "#{@carta.nombre} de #{@version.expansion.nombre}"
  end

  def create
    @version.carta = @carta
    @version.save
    respond_with(@carta, @version)
  end

  def update
    @version.update_attributes(params[:version])
    respond_with(@carta, @version)
  end

  def destroy
    @version.destroy
    respond_with(@carta, @version)
  end
end
