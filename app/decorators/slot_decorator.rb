# encoding: utf-8
class SlotDecorator < ApplicationDecorator
  decorates_association :version

  def separador
    h.separador_para (object.version.tipo || object.version.supertipo).pluralize
  end

  def entrada
    [ "#{object.cantidad} x ",
      link_con_popup ].join.html_safe
  end

  def link_con_popup
    h.link_to object.version.carta, title: version.nombre do
      [ version.nombre,
        h.content_tag(:span, version.tag, clases_del_popup) ].join.html_safe
    end
  end

  def preparar
    object.version ||= Version.new
    # Crear listas por default
    object.inventario ||= Lista.new
    self
  end

  private

    def clases_del_popup
      { class: 'popup' + ( object.version.tipo == 'Escenario' ? ' escenario' : '') }
    end
end
