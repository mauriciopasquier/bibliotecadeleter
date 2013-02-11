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
        remote: false
      },
      mostrar: {
        cantidad: {
          clases: 'mostrar-cantidad',
          cantidades: %w{ 12 20 50 },
          remote: false
        },
        tipo: {
          tipo: :arte,
          clases: 'mostrar-tipo pull-left'
        }
      }
    )

    content_tag(:div, id: opciones[:id], class: opciones[:clases]) do
      partes = ''
      partes << paginate(recursos, opciones[:kaminari]) if opciones[:paginar]
      # total_count es de Kaminari
      partes << mostrar_cantidad_tag(recursos.total_count, opciones[:mostrar][:cantidad]) if opciones[:mostrar_cantidad]
      partes << mostrar_como_tag(opciones[:mostrar][:tipo]) if opciones[:mostrar_tipo]
      partes.html_safe
    end
  end

  def mostrar_cantidad_tag(total, opciones = {})
    opciones.reverse_merge!(
      clases: 'mostrar-cantidad',
      cantidades: %w{ 12 25 50 },
      remote: false
    )
    # Si vale la pena generar el helper
    if total > opciones[:cantidades].first.to_i
      # Determinamos sólo las cantidades relevantes
      cantidades = opciones[:cantidades].select { |c| c.to_i < total } << total.to_s
      content_tag(:ul, class: opciones[:clases]) do
        cantidades.collect do |cantidad|
          nombre = cantidad.to_i == total ? 'Todo' : cantidad
          if activo? cantidad
            content_tag(:li, class: 'current disabled') do
              content_tag(:span, nombre)
            end
          else
            content_tag(:li) do
              # Para no mostrar un número gigante
              link_to(nombre,
                request.query_parameters.deep_merge(parametros(cantidad.to_i, total)),
                remote: opciones[:remote])
            end
          end
        end.join.html_safe
      end
    else
      ''
    end
  end

  def mostrar_como_tag(opciones = {})
    opciones.reverse_merge!(
      id: nil,
      tipo: :arte,
      clases: 'mostrar-tipo pull-left'
    )
    content_tag(:ul, class: opciones[:clases]) do
      content_tag(:li) do
        select_tag opciones[:id],
          options_for_select(ImagenDecorator.estilos_para_select, tipo_actual)
      end
    end
  end

  private

    # Deja params[:pagina] en la última página donde hay elementos si se pasa
    # de la cantidad.
    def parametros(cantidad, total)
      pagina = params[:pagina].to_i
      hash = HashWithIndifferentAccess.new mostrar: { cantidad: cantidad }
      # Si el link se pasa del total por menos de una página
      if cantidad * (pagina - 1) >= total
        hash.merge!( pagina: cantidad == total ? nil : total/cantidad + 1 )
      end
      hash
    end
end
