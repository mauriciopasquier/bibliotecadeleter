# encoding: utf-8
class VersionDecorator < ApplicationDecorator
  decorates :version
  decorates_association :imagenes

  # genera una imagen/link a la versión.
  # `estilo` es uno de los estilos de `Paperclip`, :original por default.
  # `opciones` se le pasa a `link_to` directamente
  def link(estilo = :original, opciones = {})
    # TODO las promocionales van al mismo link que las normales por FriendlyID
    h.link_to tag(estilo), [source.carta, source], opciones
  end

  def tag(estilo = :original)
    if imagenes.any?
      imagenes.first.tag(estilo)
    else
      opciones[:class] = "no-disponible #{opciones[:class]}"
      h.image_tag("imagen-no-disponible-#{estilo}.png",
                  alt: I18n.t('imagen.no_disponible'))
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
    "#{source.expansion.nombre} #{source.numero}/#{source.expansion.total}"
  end

  def arte
    "arte: #{artistas.collect(&:nombre).join(' - ')}"
  end

  def rareza
    case source.rareza
      when 'C' then 'Común'
      when 'I' then 'Infrecuente'
      when 'R' then 'Rara'
      when 'E' then 'Épica'
      else  '???'
    end
  end
end
