require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  # Cancan
  check_authorization unless: :devise_controller?
  alias_method  :current_user, :current_usuario
end
