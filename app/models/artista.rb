# encoding: utf-8
class Artista < ActiveRecord::Base
  attr_accessible :nombre, :web
  has_and_belongs_to_many :ilustraciones, class_name: 'Version'
  has_many :cartas, through: :ilustraciones

  validates_presence_of :nombre

  # scope que devuelve el número de cartas dibujadas por cada artista
  def self.con_ilustraciones
    joins(:ilustraciones)
      .group('artistas.id')
      .select('artistas.*, count(versiones.id) as cantidad')
  end

  scope :top5, con_ilustraciones.order('cantidad DESC').limit(5)

end
