# encoding: utf-8
class ExpansionDecorator < ApplicationDecorator
  decorates :expansion
  decorates_association :versiones
  decorates_association :imagenes

  def notas
    hash_a_dl source.notas, dl: 'notas'
  end

  def to_s
    source.nombre
  end
end
