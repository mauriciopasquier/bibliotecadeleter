# encoding: utf-8
class Mazo < ActiveRecord::Base
  include FriendlyId
  include PgSearch

  belongs_to :usuario

  # 1 o 2 demonios según el formato
  has_many :slots, as: :inventario, dependent: :destroy, include: :version
  has_many :demonios, through: :slots, source: :version,
    conditions: { supertipo: 'Demonio' }
  has_many :cartas_de_demonio, through: :demonios, source: :carta

  # 1 principal con cantidad de cartas según el formato
  has_one :principal, inverse_of: :mazo, dependent: :destroy,
    include: :slots
  # 1 suplente con cantidad de cartas según el formato
  has_one :suplente, inverse_of: :mazo, dependent: :destroy,
    include: :slots

  has_many :versiones, through: :principal
  has_many :cartas, through: :principal
  has_many :versiones_suplentes, through: :suplente, source: :versiones
  has_many :cartas_suplentes, through: :suplente, source: :cartas

  friendly_id :nombre, use: :scoped, scope: :usuario

  validates_presence_of :nombre, :principal, :usuario_id
  validates_uniqueness_of :nombre, scope: :usuario_id

  accepts_nested_attributes_for :principal, :suplente,
    allow_destroy: true, reject_if: :all_blank, update_only: true
  accepts_nested_attributes_for :slots,
    allow_destroy: true, reject_if: :all_blank, limit: 2

  scope :visibles, where(visible: true)
  scope :recientes, order('updated_at desc').limit(10)

  delegate :cantidad, to: :principal, prefix: true, allow_nil: true
  delegate :cantidad, to: :suplente, prefix: true, allow_nil: true

  multisearchable against: [ :nombre, :usuario_nombre,
    :nombres_de_las_cartas ], if: :persisted?

  delegate :nombre, to: :usuario, allow_nil: true, prefix: true

  def nombres_de_las_cartas
    (cartas + cartas_suplentes + cartas_de_demonio).uniq.collect(&:nombre).join(' ')
  end
end
