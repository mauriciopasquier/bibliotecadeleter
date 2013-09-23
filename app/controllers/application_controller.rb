# encoding: utf-8
require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  before_filter :agregar_parametros_permitidos, if: :devise_controller?

  protect_from_forgery

  # Cancan
  alias_method  :current_user, :current_usuario

  # Asegura que revisemos la autorización en cada acción, excepto en los
  # controladores de devise
  check_authorization unless: :devise_controller?

  # Recupera las excepciones por tratar de acceder a un recurso sin
  # autorización
  rescue_from CanCan::AccessDenied do |e|
    flash[:error] = I18n.t 'unauthorized.default'
    volver
  end

  rescue_from ActionController::RoutingError do |e|
    @mensaje = e.message
    respond_to do |format|
      format.html { render 'errores/404', status: 404 }
      format.json { render json: @mensaje, status: 404 }
    end
  end

  helper_method :tipo_actual, :activo?, :coleccion_actual, :reserva_actual

  protected

    def agregar_parametros_permitidos
      devise_parameter_sanitizer.for(:sign_up) << [ :nick, :codigo ]
    end

    # Redirije hacia atrás o en caso de no exister, vuelve al inicio
    def volver
      begin
        redirect_to :back
      rescue ActionController::RedirectBackError
        redirect_to :root
      end
    end

    # Para determinar el elemento activo de la paginación. En el controlador
    # porque usa params
    def activo?(elemento)
      elemento == params[:mostrar].try(:[], :cantidad)
    end

    # En el controlador porque usa params
    def tipo_actual(tipo = nil)
      (@tipo ||= (tipo || params[:tipo])).try :to_sym
    end

    def no_existe
      raise ActionController::RoutingError.new(
        'No existe este registro en la Biblioteca del Éter o en la red...'
      )
    end

    def check_espia
      if @carta.present? and @carta.slug =~ /cyborg-espia/
        no_existe
      end
    end

    def coleccion_actual
      current_usuario.try(:coleccion)
    end

    def reserva_actual
      current_usuario.try(:reserva)
    end
end
