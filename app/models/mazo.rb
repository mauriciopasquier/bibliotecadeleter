# encoding: utf-8
class Mazo < ActiveRecord::Base
  include FriendlyId

  belongs_to :usuario

  # 1 o 2 demonios según el formato
  has_many :slots, as: :inventario, dependent: :destroy, include: :version
  has_many :demonios, through: :slots, source: :version,
    conditions: { supertipo: 'Demonio' }
  # 1 principal con cantidad de cartas según el formato
  belongs_to :principal, inverse_of: :mazo, dependent: :destroy,
    include: :slots
  # 1 suplente con cantidad de cartas según el formato
  belongs_to :suplente, inverse_of: :mazo, dependent: :destroy,
    include: :slots

  has_many :versiones, through: :principal
  has_many :cartas, through: :principal
  has_many :versiones_suplentes, through: :suplente, source: :versiones
  has_many :cartas_suplentes, through: :suplente, source: :cartas

  friendly_id :nombre, use: :scoped, scope: :usuario

  before_validation :arreglar_nombres

  validates_uniqueness_of :nombre, scope: :usuario_id
  validates_presence_of :nombre
  validates_presence_of :principal

  accepts_nested_attributes_for :principal, :suplente,
    allow_destroy: true, reject_if: :all_blank, update_only: true
  accepts_nested_attributes_for :slots,
    allow_destroy: true, reject_if: :all_blank, limit: 2

  scope :publicos, where(publico: true)
  scope :recientes, order('updated_at desc').limit(10)

  delegate :cantidad, to: :principal, prefix: true, allow_nil: true
  delegate :cantidad, to: :suplente, prefix: true, allow_nil: true

  private

    def arreglar_nombres
      if nombre?
        principal.nombre = principal.uuid if principal
        suplente.nombre = suplente.uuid if suplente
      end
    end
end
