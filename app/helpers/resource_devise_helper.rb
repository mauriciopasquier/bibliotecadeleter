# encoding: utf-8
module ResourceDeviseHelper
  include DeviseHelper

  # Métodos de devise para renderizar la registración desde este controlador
  def resource
    @usuario
  end

  def resource_name
    devise_mapping.name
  end
  alias_method :scope_name, :resource_name

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:usuario]
  end

  def resource_class
    devise_mapping.to
  end
end
