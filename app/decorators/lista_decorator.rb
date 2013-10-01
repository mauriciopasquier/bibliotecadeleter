# encoding: utf-8
class ListaDecorator < ApplicationDecorator
  decorates_association :versiones, with: PaginadorDecorator
  decorates_association :slots, with: PaginadorDecorator

  def preparar
    object.slots.each do |slot|
      slot.preparar
    end
  end

  def visibilidad
    h.content_tag :span, class: "badge #{publica ? 'badge-info' : ''}" do
      object.publica ? 'Pública' : 'Privada'
    end
  end
end
