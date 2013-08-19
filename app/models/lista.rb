# encoding: utf-8
class Lista < ActiveRecord::Base
  attr_accessible :nombre

  belongs_to :usuario
  has_many :slots, as: :inventario
  has_many :versiones, through: :slots

  validates_uniqueness_of :nombre, scope: :usuario_id

  scope :publicas, where(publica: true)

  %w{Coleccion Reserva Mazo Lista}.each do |tipo|
    define_method "#{tipo.downcase}?" do
      self.type == tipo
    end
  end
end
