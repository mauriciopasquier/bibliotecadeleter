# encoding: utf-8
module InicioHelper
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
      when 'herejias'
        'Las herejías de los infernales'
      when 'arena'
        'El combate en la arena'
      when 'canon'
        'La palabra demoníaca'
      else
        nil
    end
  end

  def usuario
    @decorator ||= @usuario.decorate
  end
end
