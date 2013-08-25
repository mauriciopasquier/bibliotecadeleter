# encoding: utf-8
class InicioController < ApplicationController
  before_filter :cargar_usuario
  skip_authorization_check only: [:bienvenida]

  def panel
    authorize! :manage, @usuario
    respond_with(@usuario)
  end

  private

    def cargar_usuario
      @usuario = current_usuario
    end
end
