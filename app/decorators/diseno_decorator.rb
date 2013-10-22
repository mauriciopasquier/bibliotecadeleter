# encoding: utf-8
class DisenoDecorator < ApplicationDecorator
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

  def texto
    object.texto.split(' / ').collect do |cara|
      h.content_tag(:div, class: nil_cycle(nil, 'terrenal', name: 'texto')) do
        estructurar(cara)
      end
    end.join.html_safe unless object.texto.nil?
  end

  def anterior
    h.content_tag :span do
      h.link_to "<span class='flecha'>←</span> #{object.anterior.nombre}".html_safe,
        h.url_for([object.usuario, object.anterior]), class: 'btn', id: 'anterior'
    end
  end

  def siguiente
    h.content_tag :span do
      h.link_to "#{object.siguiente.nombre} <span class='flecha'>→</span>".html_safe,
        h.url_for([object.usuario, object.siguiente]), class: 'btn', id: 'siguiente'
    end
  end

  def fundamento
    markdown_seguro(object.fundamento)
  end

  def extracto
    object.texto.try(:truncate, 50) || ''
  end
end
