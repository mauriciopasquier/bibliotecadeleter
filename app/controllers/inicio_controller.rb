# encoding: utf-8
class InicioController < ApplicationController

  # Saltea la autorización de CanCan dado que no hay un recurso Inicio
  skip_authorization_check

  def panel
    @usuario = current_usuario.decorate
    respond_with(@usuario)
  end
end
