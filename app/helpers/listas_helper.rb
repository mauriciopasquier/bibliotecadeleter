# encoding: utf-8
module ListasHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'index'
        'Tus listas'
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

  def otras_listas
    if @usuario == current_usuario
      "Tus otras listas"
    else
      "Más listas de #{@usuario.nick}"
    end
  end

  def nuevo_slot
    Slot.new( inventario_id: @lista.id,
              inventario_type: @lista.class.name,
              version: Version.new,
              cantidad: 1)
  end

  # Para acceder al modelo decorado. Si es necesario no decorarlo, está la
  # variable de instancia
  def lista
    @decorator ||= @lista.decorate
  end

  def lista_vacia
    content_tag :p do
      p = 'No hay cartas en la lista.'

      if @usuario == current_usuario
        p << '¿Por qué no le '
        p << link_to('agregás', edit_usuario_lista_path(@usuario, @lista))
        p << ' algunas?'
      end
      p.html_safe
    end
  end

  def label_autocompletar
    :nombre_y_expansion
  end
end
