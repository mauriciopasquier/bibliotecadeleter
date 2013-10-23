# encoding: utf-8
class InicioController < ApplicationController
  before_filter :cargar_usuario
  skip_authorization_check only: [:bienvenida, :legales, :cambios]

  def panel
    authorize! :manage, @usuario
    respond_with(@usuario)
  end

  def cambios
    changelog = Kramdown::Document.new(
      File.open(Rails.root.join('CHANGELOG.mdwn')).read
    )
    render inline: changelog.to_html, layout: 'application'
  end

  private

    def cargar_usuario
      @usuario = current_usuario
    end
end
