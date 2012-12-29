# encoding: utf-8
class Version < ActiveRecord::Base
  include FriendlyId

  attr_accessible :ambientacion, :coste, :fue, :numero, :rareza, :res, :senda,
                  :subtipo, :supertipo, :texto, :tipo, :canonica,
                  :imagen_attributes, :carta

  belongs_to :carta
  has_and_belongs_to_many :artistas
  belongs_to :expansion
  has_one :imagen

  friendly_id :numero_justificado, use: :scoped, scope: :expansion

  accepts_nested_attributes_for :imagen

  validates_presence_of :carta

  def numero_justificado
    numero.to_s.rjust(3, '0')
  end
end
