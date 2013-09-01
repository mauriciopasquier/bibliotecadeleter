# encoding: utf-8
class MazoDecorator < ListaDecorator
  decorates_association :demonio
  decorates_association :slots
  decorates_association :versiones
  decorates_association :cartas
end
