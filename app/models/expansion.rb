# encoding: utf-8
class Expansion < ActiveRecord::Base
  include FriendlyId
  serialize :notas, HashWithIndifferentAccess

  attr_accessible :lanzamiento, :nombre, :notas, :presentacion, :saga, :total

  has_many :versiones, order: 'slug ASC', dependent: :destroy
  has_many :cartas, through: :versiones
  has_many :imagenes, through: :versiones, order: 'versiones.slug ASC'

  friendly_id :nombre, use: :slugged

  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  scope :grandes, where('total >= ?', 100)

  default_scope order(:lanzamiento)

  # Determina de qué expansión son las promocionales
  def base
    if slug =~ /promocionales/
      Expansion.find slug.gsub('promocionales-', '')
    else
      self
    end
  end
end
