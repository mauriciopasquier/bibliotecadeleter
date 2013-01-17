# encoding: utf-8
class Artista < ActiveRecord::Base
  include FriendlyId

  attr_accessible :nombre
  has_and_belongs_to_many :ilustraciones, class_name: 'Imagen'
  has_many :cartas, through: :ilustraciones
  has_many :links, as: :linkeable, dependent: :destroy

  friendly_id :nombre, use: :slugged

  validates_presence_of :nombre

  # scope que devuelve el número de cartas dibujadas por cada artista
  def self.con_cantidad
    joins(:ilustraciones)
      .group('artistas.id')
      .select('artistas.*, count(imagenes.id) as cantidad')
  end

  def self.con_ilustraciones
    joins { ilustraciones.outer }
  end

  def self.top5
    unscoped.con_ilustraciones.con_cantidad.order('cantidad DESC').limit(5)
  end

  default_scope order(:nombre)
end
