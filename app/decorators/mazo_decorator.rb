# encoding: utf-8
class MazoDecorator < ListaDecorator
  decorates_association :demonios
  decorates_association :slots
  decorates_association :versiones
  decorates_association :cartas
  decorates_association :principal, with: ListaDecorator
  decorates_association :suplente, with: ListaDecorator

  def preparar
    object.principal || object.build_principal
    object.suplente || object.build_suplente
    self
  end
end
