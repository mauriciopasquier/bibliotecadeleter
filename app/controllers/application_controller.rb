require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  # Cancan
  load_and_authorize_resource unless: :devise_controller?
  alias_method  :current_user, :current_usuario
end
