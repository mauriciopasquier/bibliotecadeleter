# encoding: utf-8
class SlotDecorator < ApplicationDecorator
  decorates_association :version

  def preparar
    object.version ||= Version.new
    # Crear listas por default
    object.inventario ||= Lista.new
    self
  end

  # Estos modelos con tan poca información...
  def nombre_y_expansion
    if object.version.nombre.nil?
      ''
    else
      version.nombre + " (#{version.expansion})"
    end
  end
end
