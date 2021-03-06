# encoding: utf-8
require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  before_filter :agregar_parametros_permitidos, if: :devise_controller?

  protect_from_forgery with: :reset_session

  # Cancan
  def current_user
    current_usuario
  end

  # Forem
  alias_method :forem_user, :current_user

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

  helper_method :tipo_actual, :activo?, :coleccion_actual, :coleccion_path,
                :reserva_actual, :reserva_path, :forem_user

  protected

    def agregar_parametros_permitidos
      devise_parameter_sanitizer.for(:account_update) << [
        :nick, :codigo, :nombre
      ]
      devise_parameter_sanitizer.for(:sign_up) << [
        :nick, :codigo, :nombre
      ]
    end

    # Redirije hacia atrás o en caso de no existir, vuelve al inicio
    def volver
      session[:loop].nil? ? session[:loop] = 1 : session[:loop] += 1
      begin
        raise ActionController::RedirectBackError if session[:loop] == 5
        redirect_to :back
      rescue ActionController::RedirectBackError
        session.delete :loop
        redirect_to :root
      end
    end

    # Para determinar el elemento activo de la paginación. En el controlador
    # porque usa params
    def activo?(elemento)
      elemento == params[:mostrar].try(:[], :cantidad)
    end

    # Detecta el tipo de galería a mostrar.
    def tipo_actual(tipo = nil)
      default = tipo || params[:tipo] || 'original'
      tipo_sanitizado = default.to_sym if %w{original mini arte}.include?(default)

      @tipo ||= tipo_sanitizado
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

    def coleccion_path(args = nil)
      usuario_coleccion_path(current_usuario, args)
    end

    def reserva_actual
      current_usuario.try(:reserva)
    end

    def reserva_path(args = nil)
      usuario_reserva_path(current_usuario, args)
    end

    # Para los mensajes de responders. Tenemos mayoría de modelos femeninos
    def flash_interpolation_options
      {
        del: 'de la',
        cita_crear: Cita.random_para(:crear),
        cita_actualizar: Cita.random_para(:actualizar),
        cita_destruir: Cita.random_para(:destruir),
        falla: falla
      }
    end

    # Para especificar en cada acción el mensaje de falla
    def falla
      @falla || '¿Por qué no pruebas de nuevo?'
    end
end
