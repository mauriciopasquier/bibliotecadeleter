# encoding: utf-8
module MazosHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'index'
        'Tus mazos'
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

  def separador_para(tipo)
    unless @ultimo == tipo
      @ultimo = tipo
      content_tag(:p, tipo, class: 'titulo-tipo plegable')
    end
  end

  def nuevo_slot(inventario)
    Slot.new( version: Version.new,
              inventario_id: inventario.id,
              inventario_type: inventario.class.name,
              cantidad: 4 )
  end

  def mazo
    @decorator ||= @mazo.decorate
  end

  def label_autocompletar
    :nombre_y_expansiones
  end
end
