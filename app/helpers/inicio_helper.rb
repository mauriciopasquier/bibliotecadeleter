# encoding: utf-8
module InicioHelper
  def buscar_demonios
    buscar_cartas_path(
      incluir: [versiones_tipos],
      q: {  busqueda => 'demonio',
            'versiones_senda_eq_any' => sendas } )
  end

  def titulo
    case params[:action]
      when 'panel', 'bienvenida'
        'Todo el conocimiento del Inferno'
      when 'legales'
        'La letra chica de los contratos demoníacos'
      else
        nil
    end
  end
end
