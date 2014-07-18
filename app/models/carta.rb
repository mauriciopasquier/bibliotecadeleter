# encoding: utf-8
class Carta < ActiveRecord::Base
  include FriendlyId

  has_one :canonica, -> { where(canonica: true) }, class_name: 'Version',
          dependent: :destroy

  friendly_id :nombre, use: :slugged

  has_many :versiones, -> { order('created_at DESC') },
    dependent: :destroy, inverse_of: :carta
  has_many :imagenes, -> { order('created_at ASC') }, through: :versiones
  has_many :expansiones, through: :versiones
  has_and_belongs_to_many :formatos_donde_esta_prohibida, class_name: 'Formato'

  default_scope { order(:nombre) }
  scope :ultimas, -> { reorder('created_at DESC') }

  accepts_nested_attributes_for :versiones, allow_destroy: true

  # TODO testear si puedo usar should_generate_...
  before_save :actualizar_path_de_imagenes, if: :nombre_changed?

  validates_uniqueness_of :nombre
  validates_presence_of :nombre

  delegate :prioridad, to: :canonica

  def self.con_todo
    joins(versiones: :expansion).select(
      'cartas.*, expansiones.nombre as expansion, versiones.id as version_id')
  end

  def nombre_y_expansiones
    self.nombre + " (#{self.expansiones.collect(&:nombre).join(', ')})"
  end

  # Funciona con el scope con_todo
  def nombre_y_expansion
    self.nombre + (self.expansion.nil? ? '' : " (#{self.expansion})")
  end

  def actualizar_path_de_imagenes
    versiones.each(&:actualizar_path_de_imagenes)
  end

  private

    def should_generate_new_friendly_id?
      nombre_changed? || super
    end
end
