# encoding: utf-8
class Carta < ActiveRecord::Base
  include FriendlyId

  attr_accessible :nombre, :versiones_attributes

  has_one :canonica,  class_name: 'Version', conditions: { canonica: true },
                      dependent: :destroy

  friendly_id :nombre, use: :slugged

  has_many :versiones, order: 'created_at DESC',
            dependent: :destroy, inverse_of: :carta
  has_many :imagenes, through: :versiones, order: 'created_at ASC'
  has_many :expansiones, through: :versiones

  default_scope order(:nombre).includes(:canonica)
  scope :ultimas, reorder('created_at DESC')

  accepts_nested_attributes_for :versiones, allow_destroy: true

  validates_uniqueness_of :nombre

  delegate :prioridad, to: :canonica

  def self.con_todo
    joins(versiones: :expansion).select(
      'cartas.*, expansiones.nombre as expansion, versiones.id as version_id')
  end

  def nombre_y_expansion
    self.nombre + (self.expansion.nil? ? '' : " (#{self.expansion})")
  end
end
