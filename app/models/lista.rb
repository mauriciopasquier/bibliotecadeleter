class Lista < ActiveRecord::Base
  attr_accessible :nombre

  belongs_to :usuario
  has_many :slots
  has_many :cartas, through: :slots

  validates_uniqueness_of :nombre, scope: :usuario_id
end
