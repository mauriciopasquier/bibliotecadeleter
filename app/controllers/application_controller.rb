class ApplicationController < ActionController::Base
  protect_from_forgery

  # Cancan
  check_authorization unless: :devise_controller?
  alias_method  :current_user, :current_usuario
end
