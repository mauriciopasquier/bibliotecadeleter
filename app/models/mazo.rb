# encoding: utf-8
class Mazo < ActiveRecord::Base
  include FriendlyId
  include PgSearch

  belongs_to :usuario

  attr_accessor :reglas, :exigir_formato

  # 1 o 2 demonios según el formato
  has_many :slots, as: :inventario, dependent: :destroy, include: :version
  has_many :demonios, through: :slots, source: :version,
    conditions: { supertipo: 'Demonio' }, extend: VersionesContadas
  has_many :cartas_de_demonio, through: :demonios, source: :carta

  # 1 principal con cantidad de cartas según el formato
  has_one :principal, inverse_of: :mazo, dependent: :destroy,
    include: :slots
  # 1 suplente con cantidad de cartas según el formato
  has_one :suplente, inverse_of: :mazo, dependent: :destroy,
    include: :slots
  belongs_to :formato_objetivo, class_name: 'Formato',
    inverse_of: :mazos_dedicados

  # 2 listas: principal y suplente
  has_many :listas
  has_many :versiones, through: :listas, extend: VersionesContadas
  has_many :cartas, through: :listas

  friendly_id :nombre, use: :scoped, scope: :usuario

  validates_presence_of :nombre, :principal, :usuario_id
  validates_uniqueness_of :nombre, scope: :usuario_id
  validate  :cantidad_de_demonios_correcta, :cantidad_de_cartas_correcta,
            :cantidad_de_cartas_suplentes_correcta, :copias_dentro_del_maximo,
            :sendas_corresponden_con_demonios, if: :exigir_formato

  accepts_nested_attributes_for :principal, :suplente,
    allow_destroy: true, reject_if: :all_blank, update_only: true
  accepts_nested_attributes_for :slots,
    allow_destroy: true, reject_if: :all_blank

  scope :visibles, where(visible: true)
  scope :recientes, order('updated_at desc').limit(10)

  delegate :cantidad, to: :principal, prefix: true, allow_nil: true
  delegate :cantidad, to: :suplente, prefix: true, allow_nil: true

  multisearchable against: [ :nombre, :usuario_nombre,
    :nombres_de_las_cartas, :formato_nombre ], if: :persisted?

  delegate :nombre, to: :usuario, allow_nil: true, prefix: true
  delegate :nombre, to: :formato_objetivo, allow_nil: true, prefix: :formato

  def reglas
    @reglas ||= Reglas.new(formato_objetivo, self)
  end

  def validar_en(formato)
    Reglas.new(formato, self)
  end

  private

    def nombres_de_las_cartas
      (cartas + cartas_de_demonio).uniq.collect(&:nombre).join(' ')
    end

    def cantidad_de_demonios_correcta
      errors.add :demonios, :cantidad_mal unless reglas.demonios_validos?
    end

    def cantidad_de_cartas_correcta
      errors.add :principal, :cantidad_mal unless reglas.mazo_principal_valido?
    end

    def cantidad_de_cartas_suplentes_correcta
      errors.add :suplente, :cantidad_mal unless reglas.mazo_suplente_valido?
    end

    def copias_dentro_del_maximo
      errors.add :base, :hay_copias_de_mas unless reglas.copias_validas?
    end

    def sendas_corresponden_con_demonios
      errors.add :base, :cartas_en_las_sendas_incorrectas unless reglas.sendas_validas?
    end
end
