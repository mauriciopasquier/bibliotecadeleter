# encoding: utf-8
class ImagenDecorator < ApplicationDecorator
  decorates :imagen

  def tag(estilo = :original)
    h.image_tag source.archivo.url(estilo), alt: source.carta.nombre
  end

  # genera una imagen/link a la versión.
  # `estilo` es uno de los estilos de `Paperclip`, :original por default.
  # `opciones` se le pasa a `link_to` directamente
  def link(estilo = :original, opciones = {})
    h.link_to tag(estilo), [source.carta, source.version], opciones
  end
end
