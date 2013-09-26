# encoding: utf-8
class ImagenDecorator < ApplicationDecorator
  decorates_association :version
  decorates_association :expansion
  decorates_association :artistas, with: PaginadorDecorator

  def self.estilos_para_select
    Imagen.estilos.inject({ 'Texto' => :texto }) do |h, e|
      h[e.to_s.humanize] = e
      h
    end
  end

  def tag(estilo = :original)
    [ h.image_tag(object.archivo.url(estilo),
        alt: nombre_disponible, class: 'lazy'),

      h.content_tag(:noscript) do
        h.x_image_tag(object.archivo.url(estilo),
          alt: nombre_disponible)
      end ].join.html_safe
  end

  # genera una imagen/link a la versión.
  # `estilo` es uno de los estilos de `Paperclip`, :original por default.
  # `opciones` se le pasa a `link_to` directamente
  # TODO DRY con decorador/version
  def link(estilo = :original, opciones = {})
    h.link_to tag(estilo),
      h.en_expansion_carta_path(object.carta, object.expansion), opciones
  end

  def linea_de_tipos
    version.linea_de_tipos
  end

  private

    def nombre_disponible
      (object.carta.try(:nombre) || 'Imagen no disponible')
    end
end
