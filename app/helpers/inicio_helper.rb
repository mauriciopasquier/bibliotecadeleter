# encoding: utf-8
module InicioHelper
  include DeviseHelper

  def buscar_demonios
    cartas_busqueda_path(
      incluir: [versiones_tipos],
      q: {  busqueda => 'demonio',
            'versiones_senda_eq_any' => sendas } )
  end

  def titulo
    case params[:action]
      when 'bienvenida'
        'Todo el conocimiento del Inferno'
      when 'legales'
        'La letra chica de los contratos demoníacos'
      when 'panel'
        "#{current_usuario.nick}"
      else
        nil
    end
  end

  def usuario
    @decorator ||= @usuario.decorate
  end

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
