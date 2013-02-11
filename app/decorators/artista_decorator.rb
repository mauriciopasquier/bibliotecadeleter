# encoding: utf-8
class ArtistaDecorator < ApplicationDecorator
  with_options with: PaginadorDecorator do |d|
    d.decorates_association :versiones
    d.decorates_association :ilustraciones
  end
end
