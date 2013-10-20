# encoding: utf-8
class ExpansionDecorator < ApplicationDecorator
  with_options with: PaginadorDecorator do |d|
    d.decorates_association :versiones
    d.decorates_association :imagenes
  end

  def notas_con_formato
    markdown_seguro(object.notas)
  end

  def to_s
    object.nombre
  end

  def formatos
    object.formatos.map do |f|
      h.link_to f.nombre, f
    end.join(' - ').html_safe
  end

  def logo
    [ h.image_tag(object.base.logo.url, class: 'lazy'),

      h.content_tag(:noscript) do
        h.x_image_tag(object.base.logo.url)
      end ].join.html_safe
  end
end
