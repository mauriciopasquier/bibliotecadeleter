# encoding: utf-8
module ListasHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'index'
        "Listas de #{@usuario.nick}"
      when 'show'
        lista.nombre
      when 'new'
        'Nueva lista de cartas'
      when 'edit'
        lista.nombre
      else
        nil
    end
  end

  def nuevo_slot
    Slot.new(
      inventario_id: @lista.id,
      inventario_type: @lista.class.name,
      version: Version.new,
      cantidad: 1
    )
  end

  # Para acceder al modelo decorado. Si es necesario no decorarlo, está la
  # variable de instancia
  def lista
    @decorator ||= @lista.decorate
  end

  def label_autocompletar
    :nombre_y_expansion
  end
end
