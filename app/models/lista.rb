# encoding: utf-8
class Lista < ActiveRecord::Base
  include FriendlyId

  belongs_to :usuario
  has_many :slots, as: :inventario, include: :version, dependent: :destroy
  has_many :versiones, through: :slots
  has_many :cartas, through: :versiones

  friendly_id :nombre, use: :scoped, scope: :usuario

  validates_uniqueness_of :nombre, scope: :usuario_id
  validates_presence_of :nombre

  accepts_nested_attributes_for :slots, allow_destroy: true,
    reject_if: :all_blank

  scope :publicas, where(publica: true)
  scope :recientes, order('updated_at desc').limit(10)

  %w{Lista Coleccion Reserva Principal Suplente}.each do |tipo|
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
