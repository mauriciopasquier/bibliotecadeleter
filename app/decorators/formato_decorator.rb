class FormatoDecorator < ApplicationDecorator
  def expansiones_legales
    object.expansiones.ordenadas.map do |e|
      h.link_to e.nombre, e
    end.join.html_safe
  end

  def nombres_de_cartas_prohibidas
    object.cartas_prohibidas.collect(&:nombre).join(', ')
  end

  def limite_por_sendas?
    object.limitar_sendas ? 'Sí' : 'No'
  end
end
