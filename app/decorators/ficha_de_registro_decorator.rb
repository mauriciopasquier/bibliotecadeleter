# encoding: utf-8
class FichaDeRegistroDecorator < ApplicationDecorator
  def suplente_cantidad
    object.suplente_cantidad.to_s
  end

  def principal_cantidad
    object.principal_cantidad.to_s
  end

  def usuario
    context[:usuario].try(:nombre) || ''
  end

  def codigo
    context[:usuario].try(:codigo) || ''
  end

  def cartas
    object.principal.slots.decorate with: SlotFichaDeRegistroDecorator
  end

  def suplentes
    if object.suplente.present?
      object.suplente.slots.decorate with: SlotFichaDeRegistroDecorator
    else
      []
    end
  end

  def demonio
    object.demonios.collect(&:nombre).join(' - ')
  end
end
