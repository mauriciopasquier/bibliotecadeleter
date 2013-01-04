# encoding: utf-8
class Expansion < ActiveRecord::Base
  include FriendlyId
  serialize :notas, HashWithIndifferentAccess

  attr_accessible :lanzamiento, :nombre, :notas, :presentacion, :saga, :total

  has_many :versiones
  has_many :cartas, through: :versiones

  friendly_id :nombre, use: :slugged

  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  scope :grandes, where('total >= ?', 100)

  def to_s
    nombre
  end
end
