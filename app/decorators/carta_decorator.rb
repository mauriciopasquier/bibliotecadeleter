# encoding: utf-8
class CartaDecorator < ApplicationDecorator
  decorates :carta
  decorates_association :versiones
  decorates_association :canonica

  # genera una imagen/link a la versión canónica.
  # `estilo` es uno de los estilos de `Paperclip`, :original por default.
  # `opciones` se le pasa a `link_to` directamente
  def link(estilo = :original, opciones = {})
    h.link_to canonica.tag, source, opciones
  end
end
