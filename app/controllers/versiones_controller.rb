# encoding: utf-8
class VersionesController < ApplicationController

  load_and_authorize_resource :carta
  load_and_authorize_resource through: :carta

  before_filter :check_espia
  before_filter :decorar, only: [:index, :show, :edit]

  def index
    @titulo = "#{@carta.nombre}"
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

  private

    def decorar
      @carta = @carta.decorate
      if @versiones
        @versiones = @versiones.decorate
      else
        @version = @version.decorate
      end
    end
end
