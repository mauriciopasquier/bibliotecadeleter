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

  def link_al_formato
    formato = object.formato_objetivo.try(:nombre)

    if formato.present?
      h.link_to formato, formato_objetivo
    else
      'Casual'
    end
  end

  def link_a_demonios
    demonios.collect do |demonio|
      demonio.link_con_popup
    end.join(', ').html_safe
  end

  def formatos_donde_es_legal
    formatos = Formato.all.collect do |formato|
      if formato.reglas_para(object).valid?
        h.content_tag :li, h.link_to(formato.nombre, formato)
      end
    end
    formatos.any? ? formatos.join.html_safe : h.content_tag(:li, 'ningún formato')
  end

  def notas_con_formato
    markdown_seguro(object.notas)
  end
end
