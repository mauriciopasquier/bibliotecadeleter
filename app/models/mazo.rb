# encoding: utf-8
class Mazo < ActiveRecord::Base
  attr_accessible :nombre, :slots_attributes, :formato

  belongs_to :usuario

  # 1 o 2 demonios según el formato
  has_many :slots, as: :inventario, dependent: :destroy
  has_many :demonios, through: :slots, source: :version,
    conditions: { supertipo: 'Demonio' }
  # 1 principal con cantidad de cartas según el formato
  belongs_to :principal, inverse_of: :mazo, dependent: :destroy, touch: true
  # 1 suplente con cantidad de cartas según el formato
  belongs_to :suplente, inverse_of: :mazo, dependent: :destroy, touch: true

  has_many :versiones, through: :principal
  has_many :cartas, through: :principal
  has_many :versiones_suplentes, through: :suplente, source: :versiones
  has_many :cartas_suplentes, through: :suplente, source: :cartas

  validates_presence_of :principal

  accepts_nested_attributes_for :principal, :suplente, :slots, allow_destroy: true,
    reject_if: :all_blank

  scope :publicos, where(publico: true)
  scope :recientes, order('updated_at desc').limit(10)

  def cantidad
    self.principal.cantidad + (self.suplente.try(:cantidad) || 0)
  end
end
