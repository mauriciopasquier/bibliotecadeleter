# encoding: utf-8
class VersionDecorator < ApplicationDecorator
  decorates_association :imagenes, with: PaginadorDecorator
  decorates_association :expansion

  # genera una imagen/link a la versión.
  # `estilo` es uno de los estilos de `Paperclip`, :original por default.
  # `opciones` se le pasa a `link_to` directamente
  def link(estilo = :original, opciones = {})
    h.link_to tag(estilo), [object.carta, object], opciones
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
    object.tipo || ''
  end

  def supertipo
    if object.supertipo?
      if object.tipo =~ /Arma/i and object.supertipo =~ /nstantáneo/
        " #{object.supertipo.gsub('nstantáneo', 'nstantánea')}"
      else
        " #{object.supertipo}"
      end
    else
      ''
    end
  end

  def subtipo
    if object.subtipo?
      " - #{object.subtipo}"
    else
      ''
    end
  end

  def numeracion
    if expansion.present?
      h.link_to(expansion.base.nombre, expansion.base) + " #{object.numero}/#{expansion.base.total}"
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
    object.texto.split('/').collect do |cara|
      h.content_tag(:p, class: nil_cycle(nil, 'terrenal', name: 'texto')) do
        cara
      end
    end.join.html_safe unless object.texto.nil?
  end

  def reserva_y_coleccion
    h.content_tag(:div, class: 'controles') do
      [ control_reserva,
        control_coleccion
      ].join.html_safe
    end
  end

  def control_reserva(lista = h.reserva_actual)
    c = cantidad_en(lista)

    h.content_tag(:div, class: 'control-reserva') do
      [ "Tu reserva: ",

        h.content_tag(:span, cantidad_en(lista), class: 'cantidad'),

        h.link_to(ruta(:reserva, c + 1), method: :put, remote: true,
        class: 'update-listas agregar') do
          h.content_tag(:i, nil, class: 'icon-plus')
        end,

        '/',

        h.link_to(ruta(:reserva, [0, c - 1].max), method: :put, remote: true,
        class: 'update-listas remover') do
          h.content_tag(:i, nil, class: 'icon-minus')
        end

      ].join.html_safe
    end
  end

  def control_coleccion(lista = h.coleccion_actual)
    c = cantidad_en(lista)

    h.content_tag(:div, class: 'control-coleccion') do
      [ "Total: ",

        h.content_tag(:span, cantidad_en(lista), class: 'cantidad'),

        h.link_to(ruta(:coleccion, c + 1), method: :put, remote: true,
        class: 'update-listas agregar') do
          h.content_tag(:i, nil, class: 'icon-plus')
        end,

        '/',

        h.link_to(ruta(:coleccion, [0, c - 1].max), method: :put, remote: true,
        class: 'update-listas remover') do
          h.content_tag(:i, nil, class: 'icon-minus')
        end

      ].join.html_safe
    end
  end

  private

    def cantidad_en(lista)
      object.slot_en(lista).try(:cantidad) || 0
    end

    def ruta(lista, cantidad)
      h.send("#{lista}_path",
        version_id: object,
        cantidad: cantidad
      )
    end
end
