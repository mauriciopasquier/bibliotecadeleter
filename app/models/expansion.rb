# encoding: utf-8
class Expansion < ActiveRecord::Base
  attr_accessible :lanzamiento, :nombre, :notas, :presentacion, :saga, :total

  has_many :versiones
  has_many :cartas, through: :versiones

  validates_presence_of :nombre

  def to_s
    nombre
  end
end
