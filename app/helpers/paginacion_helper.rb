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
      paginate(recursos, opciones[:kaminari])
    end
  end
end
