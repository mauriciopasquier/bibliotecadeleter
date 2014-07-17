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

  def link_con_popup
    h.link_to object.carta, title: nombre, class: 'link-con-popup' do
      [ nombre,
        h.content_tag(:span, tag, clases_del_popup) ].join.html_safe
    end
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
      if object.tipo =~ /Arma/i
        " #{object.supertipo.gsub('nstantáneo', 'nstantánea').gsub('nico', 'nica')}"
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
      h.content_tag(:div, class: nil_cycle(nil, 'terrenal', name: 'texto')) do
        estructurar(cara)
      end
    end.join.html_safe unless object.texto.nil?
  end

  def reserva_y_coleccion
    h.content_tag(:div, class: 'controles') do
      [ control(h.reserva_actual, h.t('colecciones.quiero'), h.current_usuario),
        control(h.coleccion_actual, h.t('colecciones.tengo'), h.current_usuario)
      ].join.html_safe
    end
  end

  def control(lista, texto, objetos = nil)
    c = cantidad_en(lista)
    tipo = lista.class.name.downcase
    path = "update_slot_usuario_#{lista.class.name.downcase}_path"

    h.content_tag(:div, class: "control-#{tipo}") do
      tags = [ h.content_tag(:span, texto, class: 'control-texto') ]

      if h.can? :edit, lista
        tags << h.link_to(ruta(path, objetos, cantidad: c + 1), method: :put,
          title: "Agregar a #{lista.nombre}",
          remote: true, class: 'update-listas agregar') do
            h.content_tag(:i, nil, class: 'icon-plus')
          end
      end

      cantidad = "#{h.can?(:edit, lista) ? '' : 'x '}#{c}"
      tags << h.content_tag(:span, cantidad, class: 'cantidad')

      if h.can? :edit, lista
        tags <<  h.link_to(ruta(path, objetos, cantidad: [0, c - 1].max),
          title: "Remover de #{lista.nombre}",
          method: :put, remote: true, class: 'update-listas remover') do
            h.content_tag(:i, nil, class: 'icon-minus')
          end
      end

      tags.join.html_safe
    end
  end

  def preparar
    case object.supertipo
      when 'Demonio'
        object.imagenes.build if object.imagenes.count < 2
      else
        object.imagenes.build unless object.imagenes.any?
    end
    self
  end

  def anterior
    h.content_tag :span do
      h.link_to "<span class='flecha'>←</span> #{object.anterior.nombre}".html_safe,
        h.en_expansion_carta_path(
          object.anterior.carta, object.anterior.expansion), class: 'btn',
          id: 'anterior'
    end
  end

  def siguiente
    h.content_tag :span do
      h.link_to "#{object.siguiente.nombre} <span class='flecha'>→</span>".html_safe,
        h.en_expansion_carta_path(
          object.siguiente.carta, object.siguiente.expansion), class: 'btn',
          id: 'siguiente'
    end
  end

  def cantidad_en(lista)
    object.slot_en(lista).try(:cantidad) || 0
  end

  private

    def ruta(path, modelos, opciones)
      opciones.reverse_merge!({ version_id: object })
      h.send(path, *modelos, opciones)
    end

    def clases_del_popup
      { class: 'popup' + ( object.tipo == 'Escenario' ? ' escenario' : '') }
    end
end
