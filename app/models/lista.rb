class Lista < ActiveRecord::Base
  attr_accessible :nombre

  belongs_to :usuario
  has_many :slots, as: :inventario
  has_many :cartas, through: :slots,
    source: :inventariable, source_type: 'Carta'
  has_many :versiones, through: :slots,
    source: :inventariable, source_type: 'Version'

  validates_uniqueness_of :nombre, scope: :usuario_id
end
