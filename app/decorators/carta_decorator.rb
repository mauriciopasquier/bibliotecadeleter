# encoding: utf-8
class CartaDecorator < ApplicationDecorator
  with_options with: PaginadorDecorator do |d|
    d.decorates_association :versiones
    d.decorates_association :expansiones
  end
  decorates_association :canonica

  # genera una imagen/link a la versión canónica.
  # `estilo` es uno de los estilos de `Paperclip`, :original por default.
  # `opciones` se le pasa a `link_to` directamente
  def link(estilo = :original, opciones = {})
    h.link_to canonica.tag(estilo), object, opciones
  end

  def lista_de_expansiones
    object.expansiones.order(:lanzamiento).collect do |e|
      h.link_to e.nombre, e
    end.join(', ').html_safe
  end
end
