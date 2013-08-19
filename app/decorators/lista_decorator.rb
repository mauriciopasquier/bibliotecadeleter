# encoding: utf-8
class ListaDecorator < ApplicationDecorator
  decorates_association :versiones, with: PaginadorDecorator
  decorates_association :slots, with: PaginadorDecorator

  def preparar
    slots.each do |slot|
      slot.preparar
      # TODO funciona?
      slot.inventario = self
    end
    self
  end
end
