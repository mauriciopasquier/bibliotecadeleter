# encoding: utf-8
require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  # Cancan
  alias_method  :current_user, :current_usuario

  # Asegura que revisemos la autorización en cada acción, excepto en los
  # controladores de devise
  check_authorization unless: :devise_controller?

  # Carga y autoriza el recurso, creando las variables de instancia
  # correspondientes
  load_and_authorize_resource prepend: true

  # Recupera las excepciones por tratar de acceder a un recurso sin
  # autorización
  rescue_from CanCan::AccessDenied do |e|
    flash[:error] = I18n.t 'unauthorized.default'
    volver
  end

  protected

    # Redirije hacia atrás o en caso de no exister, vuelve al inicio
    def volver
      begin
        redirect_to :back
      rescue ActionController::RedirectBackError
        redirect_to :root
      end
    end

end
