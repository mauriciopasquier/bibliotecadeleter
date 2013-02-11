# encoding: utf-8
class ExpansionDecorator < ApplicationDecorator
  with_options with: PaginadorDecorator do |d|
    d.decorates_association :versiones
    d.decorates_association :imagenes
  end

  def notas
    hash_a_dl source.notas, dl: 'notas dl-horizontal'
  end

  def to_s
    source.nombre
  end
end
