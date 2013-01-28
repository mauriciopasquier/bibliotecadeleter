# encoding: utf-8
class ArtistaDecorator < ApplicationDecorator
  decorates :artista
  decorates_association :versiones
  decorates_association :ilustraciones
end
