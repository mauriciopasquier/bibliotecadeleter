# encoding: utf-8
class Lista < ActiveRecord::Base
  attr_accessible :nombre, :slots_attributes

  belongs_to :usuario
  has_many :slots, as: :inventario
  has_many :versiones, through: :slots
  has_many :cartas, through: :versiones

  validates_uniqueness_of :nombre, scope: :usuario_id

  accepts_nested_attributes_for :slots, allow_destroy: true

  scope :publicas, where(publica: true)

  %w{Coleccion Reserva Mazo Lista}.each do |tipo|
    define_method "#{tipo.downcase}?" do
      self.type == tipo
    end
  end

  scope :normales, where(type: 'Lista')

  # Devuelve todos los slots tanto en esta lista como en `otra`
  def comparar_con(otra)
    Slot.where(inventario_id: [self, otra]).menos(otra)
  end

  # Cantidad de cartas en la lista
  def cantidad
    self.slots.sum(:cantidad)
  end
end
