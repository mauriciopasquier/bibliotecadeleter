# encoding: utf-8
class MazoDecorator < ListaDecorator
  decorates_association :demonios
  decorates_association :slots
  decorates_association :versiones
  decorates_association :cartas
  decorates_association :principal, with: ListaDecorator
  decorates_association :suplente, with: ListaDecorator

  def preparar
    object.principal || object.build_principal
    object.suplente || object.build_suplente
    self
  end

  def principal_cantidad
    object.principal_cantidad || 0
  end

  def suplente_cantidad
    object.suplente_cantidad || 0
  end

  def visibilidad_tag
    h.content_tag :span, class: "badge #{visible ? 'badge-info' : ''}" do
      visibilidad
    end
  end

  def visibilidad
    object.visible ? 'Público' : 'Privado'
  end

  def formato
    object.formato_objetivo.try(:nombre) || 'Casual'
  end
end
