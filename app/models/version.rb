class Version < ActiveRecord::Base
  attr_accessible :ambientacion, :coste, :fue, :numero, :rareza, :res, :senda,
                  :subtipo, :supertipo, :texto, :tipo, :canonica

  belongs_to :carta
  belongs_to :artista, counter_cache: :cantidad_de_ilustraciones
end
