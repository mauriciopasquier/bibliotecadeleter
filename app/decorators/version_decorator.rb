# encoding: utf-8
class VersionDecorator < ApplicationDecorator
  decorates_association :imagenes, with: PaginadorDecorator
  decorates_association :expansion

  # genera una imagen/link a la versión.
  # `estilo` es uno de los estilos de `Paperclip`, :original por default.
  # `opciones` se le pasa a `link_to` directamente
  def link(estilo = :original, opciones = {})
    h.link_to tag(estilo),
      h.en_expansion_carta_path(object.carta, object.expansion), opciones
  end

  def tag(estilo = :original)
    if imagenes.any?
      imagenes.first
    else
      Imagen.new.decorate
    end.tag(estilo)
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
    imagenes.collect do |i|
      h.content_tag(:p, class: nil_cycle(nil, 'terrenal', name: 'arte')) do
        i.artistas.collect do |a|
          h.link_to(a.nombre, a)
        end.join(' - ').html_safe
      end
    end.join.html_safe
  end

  def texto
    object.texto.split(' / ').collect do |cara|
      h.content_tag(:p, class: nil_cycle(nil, 'terrenal', name: 'texto')) do
        cara
      end
    end.join.html_safe unless object.texto.nil?
  end

  def reserva_y_coleccion
    h.content_tag(:div, class: 'controles') do
      [ control(h.reserva_actual, 'Quiero'),
        control(h.coleccion_actual, 'Tengo')
      ].join.html_safe
    end
  end

  def control(lista, texto)
    c = cantidad_en(lista)
    tipo = lista.class.name.downcase

    h.content_tag(:div, class: "control-#{tipo}") do
      [ h.content_tag(:span, texto, class: 'control-texto'),

        h.link_to(ruta(tipo, c + 1), method: :put, remote: true,
          class: 'update-listas agregar') do
            h.content_tag(:i, nil, class: 'icon-plus')
          end,

        h.content_tag(:span, c, class: 'cantidad'),

        h.link_to(ruta(tipo, [0, c - 1].max), method: :put, remote: true,
          class: 'update-listas remover') do
            h.content_tag(:i, nil, class: 'icon-minus')
          end
      ].join.html_safe
    end

  end

  def preparar
    case object.supertipo
      when 'Demonio'
        object.imagenes.build if object.imagenes.count < 2
      else
        object.imagenes.any? || object.imagenes.build
    end
    self
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
