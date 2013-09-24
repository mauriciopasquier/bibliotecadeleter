# encoding: utf-8
class ExpansionDecorator < ApplicationDecorator
  with_options with: PaginadorDecorator do |d|
    d.decorates_association :versiones
    d.decorates_association :imagenes
  end

  def notas_con_formato
    Kramdown::Document.new(object.notas).to_html.html_safe
  end

  def to_s
    object.nombre
  end
end
