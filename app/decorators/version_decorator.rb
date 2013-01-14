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
      opciones[:class] = "no-disponible #{opciones[:class]}"
      h.image_tag("imagen-no-disponible-#{estilo}.png",
                  alt: I18n.t('imagen.no_disponible'))
    end
    # TODO las promocionales van al mismo link que las normales
    h.link_to tag, [source.carta, source], opciones
  end

end
