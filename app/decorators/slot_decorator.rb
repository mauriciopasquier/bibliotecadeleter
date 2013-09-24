# encoding: utf-8
class SlotDecorator < ApplicationDecorator
  decorates_association :version

  def preparar
    object.version ||= Version.new
    # Crear listas por default
    object.inventario ||= Lista.new
    self
  end
end
