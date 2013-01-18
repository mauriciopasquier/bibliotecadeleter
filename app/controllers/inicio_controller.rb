# encoding: utf-8
class InicioController < ApplicationController

  # Saltea la autorización de CanCan dado que no hay un recurso Inicio
  skip_authorization_check

  def panel
    @usuario = current_usuario
    @titulo = "Hola #{@usuario.nick}"
    respond_with(@usuario)
  end

  def bienvenida
    @titulo = "Bienvenido mortal"
  end
end
