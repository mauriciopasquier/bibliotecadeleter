# encoding: utf-8
class VersionesController < ApplicationController

  load_and_authorize_resource :carta
  load_and_authorize_resource through: :carta

  before_filter :check_espia
  before_filter :decorar_carta_y_version, only: [:index, :show, :new, :edit]

  def index
    respond_with(@carta, @versiones)
  end

  def show
    respond_with(@carta, @version)
  end

  def new
    respond_with(@carta, @version)
  end

  def edit
    respond_with(@carta, @version)
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

    def decorar_carta_y_version
      @carta = @carta.decorate
      if @versiones
        @versiones = @versiones.decorate
      else
        @version = @version.decorate
      end
    end
end
