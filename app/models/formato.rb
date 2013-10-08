# encoding: utf-8
class Formato < ActiveRecord::Base
  include FriendlyId

  has_and_belongs_to_many :expansiones
  has_many :mazos_dedicados, inverse_of: :formato_objetivo

  friendly_id :nombre, use: :slugged
end
