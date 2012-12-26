# encoding: utf-8
class Artista < ActiveRecord::Base
  attr_accessible :nombre, :web
  has_many :ilustraciones, class_name: 'Version'
  has_many :cartas, through: :ilustraciones
end
