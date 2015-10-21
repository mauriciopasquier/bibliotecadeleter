# encoding: utf-8
class Artista < ActiveRecord::Base
  include FriendlyId
  include PgSearch

  has_and_belongs_to_many :ilustraciones, class_name: 'Imagen'
  has_many :cartas, through: :ilustraciones
  has_many :versiones, through: :ilustraciones
  has_many :links, as: :linkeable, dependent: :destroy

  validates :nombre, presence: true, uniqueness: true

  after_save :touch_ilustraciones
  before_destroy :verificar_que_no_tenga_ilustraciones

  friendly_id :nombre, use: :slugged
  multisearchable against: :nombre

  # TODO scope ilustraciones_sin_colaboracion
  # TODO scope última_colaboracion (por lanzamiento, created_at)

  # scope que devuelve el número de cartas dibujadas por cada artista. No
  # devuelve artistas sin ilustraciones
  def self.con_cantidad
    joins(:ilustraciones)
      .group('artistas.id')
      .select('artistas.*, count(imagenes.id) as cantidad')
  end

  def self.con_ilustraciones
    joins { ilustraciones.outer }
  end

  def self.top5
    con_ilustraciones.con_cantidad.reorder('cantidad DESC').limit(5)
  end

  default_scope { order(:nombre) }

  private

    def touch_ilustraciones
      if nombre_changed? || slug_changed?
        ilustraciones.find_each { |i| i.touch }
      end
    end

    def verificar_que_no_tenga_ilustraciones
      ilustraciones.empty?
    end

    def should_generate_new_friendly_id?
      nombre_changed? || super
    end
end
