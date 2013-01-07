# encoding: utf-8
class Carta < ActiveRecord::Base
  include FriendlyId

  attr_accessible :nombre, :versiones_attributes

  has_one :canonica,  class_name: 'Version', conditions: { canonica: true },
                      dependent: :destroy
  has_many :links, as: :linkeable

  friendly_id :nombre, use: :scoped, scope: :expansion

  has_many :versiones, order: 'created_at DESC', dependent: :destroy
  has_many :imagenes, through: :versiones

  accepts_nested_attributes_for :versiones, allow_destroy: true

  after_save :determinar_version_canonica

  def to_s
    nombre
  end

  private

    def determinar_version_canonica
      unless canonica.present? or versiones.empty?
        versiones.first.update_attribute(:canonica, true)
      end
    end

end
