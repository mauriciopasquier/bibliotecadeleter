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
    Slot.new inventario: @lista, version: Version.new
  end

  # Para acceder al modelo decorado. Si es necesario no decorarlo, está la
  # variable de instancia
  def lista
    @decorator ||= @lista.decorate
  end

  def lista_vacia
    content_tag :p do
      p = 'Esta lista está vacía.'

      if @usuario == current_usuario
        p << '¿Por qué no le '
        p << link_to('agregás', edit_usuario_lista_path(@usuario, @lista))
        p << ' algunas cartas?'
      end
      p.html_safe
    end
  end
end
