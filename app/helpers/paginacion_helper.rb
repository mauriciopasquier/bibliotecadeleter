# encoding: utf-8
module PaginacionHelper
  def paginacion_tag(recursos, opciones = {})
    opciones.reverse_merge!(
      id: 'paginacion',
      clases: 'pagination',
      paginar: true,
      mostrar_cantidad: true,
      mostrar_tipo: false,
      kaminari: {
        remote: true
      },
      mostrar: {
        cantidad: {
          clases: 'mostrar-cantidad',
          cantidades: %w{ 10 20 30 },
          remote: true
        },
        tipo: {
          tipo: :arte,
          clases: 'mostrar-tipo pull-right'
        }
      }
    )
    content_tag(:div, id: opciones[:id], class: opciones[:clases]) do
      partes = ''
      partes << paginate(recursos, opciones[:kaminari]) if opciones[:paginar]
      partes << mostrar_cantidad_tag(opciones[:mostrar][:cantidad]) if opciones[:mostrar_cantidad]
      partes << mostrar_como_tag(opciones[:mostrar][:tipo]) if opciones[:mostrar_tipo]
      partes.html_safe
    end
  end

  def mostrar_cantidad_tag(opciones = {})
    opciones.reverse_merge!(
      clases: 'mostrar-cantidad',
      cantidades: %w{ 10 20 30 },
      remote: true
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
      id: nil,
      tipo: :arte,
      clases: 'mostrar-tipo pull-right'
    )
    select_tag opciones[:id],
      options_for_select(Imagen.estilos, tipo_actual), class: opciones[:clases]
  end
end