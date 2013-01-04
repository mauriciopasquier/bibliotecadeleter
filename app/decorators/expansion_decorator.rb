# encoding: utf-8
class ExpansionDecorator < ApplicationDecorator
  decorates :expansion

  def notas
    hash_a_dl source.notas, dl: 'notas'
  end

end
