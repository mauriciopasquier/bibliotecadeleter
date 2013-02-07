# encoding: utf-8
class InicioController < ApplicationController

  # Saltea la autorización de CanCan dado que no hay un recurso Inicio
  skip_authorization_check

  def panel
    @usuario = current_usuario
    @titulo = "Todo el conocimiento del Inferno"
    respond_with(@usuario)
  end

  def bienvenida
    @titulo = "Todo el conocimiento del Inferno"
  end

  def legales
    @titulo = "Algunas cuestiones legales imprescindibles"
  end
end
