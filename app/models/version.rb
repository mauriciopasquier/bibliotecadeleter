# encoding: utf-8
class Version < ActiveRecord::Base
  attr_accessible :ambientacion, :coste, :fue, :numero, :rareza, :res, :senda,
                  :subtipo, :supertipo, :texto, :tipo, :canonica,
                  :imagen_attributes

  belongs_to :carta
  belongs_to :artista, counter_cache: :cantidad_de_ilustraciones
  belongs_to :expansion
  has_one :imagen

  accepts_nested_attributes_for :imagen
end
