# encoding: utf-8
class ListaDecorator < ApplicationDecorator
  decorates_association :cartas, with: PaginadorDecorator
end
