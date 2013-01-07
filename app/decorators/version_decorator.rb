# encoding: utf-8
class VersionDecorator < ApplicationDecorator
  decorates :version
  decorates_association :imagenes

  # genera una imagen/link a la versión.
  # `estilo` es uno de los estilos de `Paperclip`, :original por default.
  # `opciones` se le pasa a `link_to` directamente
  def link(estilo = :original, opciones = {})
    tag = if imagenes.any?
      imagenes.first.tag(estilo)
    else
      h.image_tag('imagen-no-disponible-thumb.png',
                  alt: I18n.t('imagen.no_disponible'),
                  class: 'no-disponible')
    end
    h.link_to tag, [source.carta, source], opciones
  end

end
