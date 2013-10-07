# encoding: utf-8
class ListaDecorator < ApplicationDecorator
  decorates_association :versiones, with: PaginadorDecorator
  decorates_association :slots, with: PaginadorDecorator

  def preparar
    object.slots.each do |slot|
      slot.preparar
    end
  end

  def visibilidad_tag
    h.content_tag :span, class: "badge #{visible ? 'badge-info' : ''}" do
      visibilidad
    end
  end

  def visibilidad
    object.visible ? 'Pública' : 'Privada'
  end
end
