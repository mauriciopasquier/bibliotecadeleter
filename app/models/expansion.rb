# encoding: utf-8
class Expansion < ActiveRecord::Base
  include FriendlyId
  serialize :notas, HashWithIndifferentAccess

  attr_accessible :lanzamiento, :nombre, :notas, :presentacion, :saga, :total

  has_many :versiones, order: 'slug ASC'
  has_many :cartas, through: :versiones
  has_many :imagenes, through: :versiones, order: 'versiones.slug ASC'

  friendly_id :nombre, use: :slugged

  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  scope :grandes, where('total >= ?', 100)

  default_scope order(:lanzamiento)

  def to_s
    nombre
  end
end