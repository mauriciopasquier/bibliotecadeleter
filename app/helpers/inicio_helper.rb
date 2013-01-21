# encoding: utf-8
module InicioHelper
  def buscar_demonios
    buscar_cartas_path(
      incluir: [versiones_tipos],
      q: {  busqueda => 'demonio',
            'versiones_senda_eq_any' => sendas } )
  end
end
