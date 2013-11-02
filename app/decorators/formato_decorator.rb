class FormatoDecorator < ApplicationDecorator
  def expansiones_legales
    if object.expansiones.any?
      object.expansiones.ordenadas.map do |e|
        h.link_to e.nombre, e
      end.join.html_safe
    else
      'Cualquiera'
    end
  end

  def nombres_de_cartas_prohibidas
    object.cartas_prohibidas.collect(&:nombre).join(', ')
  end

  def limite_por_sendas?
    object.limitar_sendas ? 'Sí' : 'No'
  end

  def copias_o_no
    object.copias || 'Sin límite'
  end

  def suplente_o_no
    object.suplente || 'El resto'
  end

  def ids_de_expansion
    object.expansion_ids.join(', ')
  end
end
