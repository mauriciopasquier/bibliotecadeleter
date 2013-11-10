# encoding: utf-8
module MazosHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'index'
        usuario.actual? ? 'Tus mazos' : "Mazos de #{@usuario.nick}"
      when 'show'
        mazo.nombre
      when 'new'
        'Nuevo mazo'
      when 'edit'
        mazo.nombre
      else
        nil
    end
  end

  def otros_mazos
    usuario.actual? ? 'Tus otros mazos' : "Mazos de #{@usuario.nick}"
  end

  def separador_para(tipo)
    unless @ultimo == tipo
      @ultimo = tipo
      content_tag(:p, tipo, class: 'titulo-tipo')
    end
  end

  def reiniciar_separador
    @ultimo = nil
  end

  def nuevo_slot(inventario, cantidad = 4)
    Slot.new( version: Version.new,
              inventario_id: inventario.id,
              inventario_type: inventario.class.name,
              cantidad: cantidad )
  end

  def mazo
    @decorator ||= @mazo.decorate
  end

  def label_autocompletar
    :nombre_y_expansiones
  end

  def span_del_mazo
    "span#{@mazo.notas? ? 4 : 12}"
  end
end
