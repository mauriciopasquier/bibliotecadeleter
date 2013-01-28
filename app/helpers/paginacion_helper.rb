# encoding: utf-8
module PaginacionHelper
  def paginacion_tag(recursos, opciones = {})
    opciones.reverse_merge!(
      id: 'paginacion',
      clases: 'pagination pagination-centered',
      kaminari: { remote: true },
      mostrar: {  clases: 'mostrar',
                  remote: true }
    )
    content_tag(:div, id: opciones[:id], class: opciones[:clases]) do
      paginate(recursos, opciones[:kaminari]) +
      mostrar_cantidad_tag(opciones[:mostrar])
    end
  end

  def mostrar_cantidad_tag(opciones = {})
    opciones.reverse_merge!(
      clases: 'mostrar',
      cantidades: %w{ 10 20 30 },
    )
    content_tag(:ul, class: opciones[:clases]) do
      opciones[:cantidades].collect do |cantidad|
        if activo? cantidad
          content_tag(:li, class: 'current disabled') do
            content_tag(:span, cantidad)
          end
        else
          content_tag(:li) do
            link_to(cantidad, url_for(mostrar: { cantidad: cantidad }),
              remote: opciones[:remote])
          end
        end
      end.join.html_safe
    end
  end

  def mostrar_como_tag(opciones = {})
    opciones.reverse_merge!(
      tipo: :thumb,
      clases: 'mostrar-como'
    )
    select_tag opciones[:clases],
      options_for_select(Imagen.estilos, tipo_actual), class: 'seleccion-estilos'
  end
end
