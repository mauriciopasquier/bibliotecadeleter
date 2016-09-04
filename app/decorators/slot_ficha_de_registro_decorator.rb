# encoding: utf-8
class SlotFichaDeRegistroDecorator < ApplicationDecorator
  def carta
    object.version.nombre
  end

  def cantidad
    object.cantidad.to_s
  end

  def completa
    [
      cantidad,
      Prawn::Text::NBSP * 15,
      carta
    ].join
  end
end
