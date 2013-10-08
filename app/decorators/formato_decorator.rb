class FormatoDecorator < ApplicationDecorator
  def expansiones_legales
    object.expansiones.ordenadas.map do |e|
      h.link_to e.nombre, e
    end.join.html_safe
  end
end
