# encoding: utf-8
class VersionDecorator < ApplicationDecorator
  decorates_association :imagenes, with: PaginadorDecorator
  decorates_association :expansion

  # genera una imagen/link a la versión.
  # `estilo` es uno de los estilos de `Paperclip`, :original por default.
  # `opciones` se le pasa a `link_to` directamente
  def link(estilo = :original, opciones = {})
    h.link_to tag(estilo), [source.carta, source], opciones
  end

  def tag(estilo = :original)
    if imagenes.any?
      imagenes.first.tag(estilo)
    else
      h.content_tag(:div, class: 'no-disponible') do
        h.image_tag("imagen-no-disponible-#{estilo}.png",
                    alt: I18n.t('imagen.no_disponible'))
      end
    end
  end

  def linea_de_tipos
    (tipo + supertipo + subtipo).strip
  end

  def tipo
    source.tipo || ''
  end

  def supertipo
    if source.supertipo?
      if source.tipo =~ /Arma/i and source.supertipo =~ /nstantáneo/
        " #{source.supertipo.gsub('nstantáneo', 'nstantánea')}"
      else
        " #{source.supertipo}"
      end
    else
      ''
    end
  end

  def subtipo
    if source.subtipo?
      " - #{source.subtipo}"
    else
      ''
    end
  end

  def numeracion
    if expansion.present?
      h.link_to(expansion.base.nombre, expansion.base) + " #{source.numero}/#{expansion.base.total}"
    end
  end

  def arte
    # TODO devolver una sola línea si ambas caras tienen los mismos artistas
    imagenes.collect do |i|
      h.content_tag(:p, class: nil_cycle(nil, 'terrenal', name: 'arte')) do
        i.artistas.collect do |a|
          h.link_to(a.nombre, a)
        end.join(' - ').html_safe
      end
    end.join.html_safe
  end

  def texto
    source.texto.split('/').collect do |cara|
      h.content_tag(:p, class: nil_cycle(nil, 'terrenal', name: 'texto')) do
        cara
      end
    end.join.html_safe unless source.texto.nil?
  end
end
