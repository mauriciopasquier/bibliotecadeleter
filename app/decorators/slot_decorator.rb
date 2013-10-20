# encoding: utf-8
class SlotDecorator < ApplicationDecorator
  decorates_association :version

  def separador
    h.separador_para (object.version.tipo || object.version.supertipo).pluralize
  end

  def entrada
    [ "#{object.cantidad} x ",
      version.link_con_popup ].join.html_safe
  end

  def preparar
    object.version ||= Version.new
    # Crear listas por default
    object.inventario ||= Lista.new
    self
  end
end
