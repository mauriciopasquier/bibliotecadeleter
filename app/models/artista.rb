# encoding: utf-8
class Artista < ActiveRecord::Base
  attr_accessible :nombre, :web
  has_and_belongs_to_many :ilustraciones, class_name: 'Version'
  has_many :cartas, through: :ilustraciones

  validates_presence_of :nombre
end
