# encoding: utf-8
class InicioController < ApplicationController

  skip_load_and_authorize_resource
  skip_authorization_check

  def panel
    @usuario = current_usuario
    respond_with(@usuario)
  end

  def bienvenida
  end
end
