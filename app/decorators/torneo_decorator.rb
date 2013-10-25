# encoding: utf-8
class TorneoDecorator < ApplicationDecorator
  def identificador
    "#{object.formato_nombre} en #{object.tienda_nombre} el #{object.fecha}"
  end
end
