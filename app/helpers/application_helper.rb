# encoding: utf-8
module ApplicationHelper

  # Hay que llamarlo con != en haml para que interprete el html
  # TODO convertir a _tag
  def mensajes(flash)
    html = "<div class='flash'>"
    flash.each do |tipo, mensaje|
      html << "<div class='message #{tipo == :alert ? :error : tipo}'><p>#{mensaje }</p></div>"
    end
    html << '</div>'
  end

  def titulo
    "Biblioteca Del Eter#{@titulo ? " | #{@titulo}" : nil}"
  end

  def expansiones(scope = :all)
    Expansion.unscoped.send scope
  end

  def artistas(scope = :all)
    Artista.unscoped.send scope
  end

  def link_to_mostrar(recurso)
    link_to recurso do
      content_tag(:i, nil, class: 'icon-zoom-in') + 'Mostrar'
    end
  end

  def link_to_editar(recurso)
    link_to recurso do
      content_tag(:i, nil, class: 'icon-pencil') + 'Editar'
    end
  end

  def link_to_eliminar(recurso)
    link_to recurso, method: :delete, data: { confirm: t(:confirmar) } do
      content_tag(:i, nil, class: 'icon-remove-circle') + 'Eliminar'
    end
  end
end
