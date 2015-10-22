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

  # alt: nil es para poder copiar y pegar el texto sin repeticiones
  def tag(estilo = :original)
    [ h.image_tag(object.archivo.url(estilo),
        alt: nil, size: size(estilo),
        class: 'lazy', lazy: true),

      h.content_tag(:noscript) do
        h.rails_image_tag(object.archivo.url(estilo),
          alt: nil)
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

  def nombre_de_cara
    object.cara? ? 'infernal' : 'terrenal'
  end

  # En algún lado pasamos nil por :original
  def size(estilo)
    case estilo
    when :mini, 'mini'
      object.geometria_mini
    when :arte, 'arte'
      object.geometria_arte
    else
      object.geometria_original
    end
  end

  private

    def nombre_disponible
      (object.carta.try(:nombre) || 'Imagen no disponible')
    end
end
