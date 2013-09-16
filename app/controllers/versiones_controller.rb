# encoding: utf-8
class VersionesController < ApplicationController
  autocompletar_columnas :tipo, :supertipo, :subtipo

  ANONS = [ :completar_tipo, :completar_supertipo, :completar_subtipo ]

  load_and_authorize_resource :carta, except: ANONS
  load_and_authorize_resource through: :carta, except: ANONS
  skip_authorization_check only: ANONS

  before_filter :check_espia

  def new
    respond_with(@carta)
  end

  def edit
    respond_with(@carta, @version)
  end

  def destroy
    @version.destroy
    respond_with(@carta, @version, location: @carta)
  end
end
