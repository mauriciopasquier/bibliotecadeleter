# encoding: utf-8
class Expansion < ActiveRecord::Base
  include FriendlyId
  store :notas

  attr_accessible :lanzamiento, :nombre, :notas, :presentacion, :saga, :total

  has_many :versiones
  has_many :cartas, through: :versiones

  friendly_id :nombre, use: :slugged

  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  def to_s
    nombre
  end
end
