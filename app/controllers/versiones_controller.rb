# encoding: utf-8
class VersionesController < ApplicationController
  autocompletar_columnas :tipo, :supertipo, :subtipo

  ANONS = [ :completar_tipo, :completar_supertipo, :completar_subtipo ]

  load_and_authorize_resource :carta, except: ANONS
  load_and_authorize_resource through: :carta, except: ANONS
  skip_authorization_check only: ANONS

  before_filter :check_espia
  before_filter :decorar_carta_y_version, only: [:index, :show, :new, :edit]

  def index
    respond_with(@carta, @versiones)
  end

  def show
    respond_with(@carta, @version)
  end

  def new
    respond_with(@carta)
  end

  def edit
    respond_with(@carta)
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
