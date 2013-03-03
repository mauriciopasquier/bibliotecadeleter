# encoding: utf-8
class Carta < ActiveRecord::Base
  include FriendlyId

  attr_accessible :nombre, :versiones_attributes

  has_one :canonica,  class_name: 'Version', conditions: { canonica: true },
                      dependent: :destroy

  friendly_id :nombre, use: :slugged

  has_many :versiones, order: 'created_at DESC', dependent: :destroy
  has_many :imagenes, through: :versiones, order: 'created_at ASC'
  has_many :expansiones, through: :versiones

  default_scope order(:nombre).includes(:canonica)
  scope :ultimas, reorder('created_at DESC')

  accepts_nested_attributes_for :versiones, allow_destroy: true

  def to_s
    nombre
  end

  delegate :prioridad, to: :canonica
end
