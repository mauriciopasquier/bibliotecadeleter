# encoding: utf-8
class Version < ActiveRecord::Base
  include FriendlyId

  attr_accessible :ambientacion, :coste, :fue, :numero, :rareza, :res, :senda,
                  :subtipo, :supertipo, :texto, :tipo, :canonica,
                  :imagenes_attributes, :carta, :expansion

  belongs_to :carta
  has_and_belongs_to_many :artistas
  belongs_to :expansion
  has_many :imagenes

  friendly_id :expansion_y_numero, use: :slugged

  accepts_nested_attributes_for :imagenes

  validates_presence_of :carta

  def numero_justificado
    numero.to_s.rjust(3, '0')
  end

  private

    def expansion_y_numero
      "#{expansion.slug}-#{numero_justificado}"
    end

end
