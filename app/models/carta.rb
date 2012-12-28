# encoding: utf-8
class Carta < ActiveRecord::Base
  attr_accessible :nombre, :versiones_attributes

  has_one :canonica,  class_name: 'Version', conditions: { canonica: true },
                      dependent: :destroy

  has_many :versiones, order: 'created_at DESC'
  has_many :imagenes, through: :versiones

  accepts_nested_attributes_for :versiones, allow_destroy: true

  def to_s
    nombre
  end
end
