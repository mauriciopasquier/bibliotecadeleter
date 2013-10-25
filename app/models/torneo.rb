class Torneo < ActiveRecord::Base
  include FriendlyId
  include PgSearch

  belongs_to :tienda
  belongs_to :organizador, class_name: 'Usuario'
  belongs_to :formato

  has_many :inscripciones
  has_many :usuarios, through: :inscripciones
  # TODO congelar los mazos en Inscripcion?
  # has_many :mazos, through: :inscripciones

  multisearchable against: [ :fecha, :direccion, :tienda_nombre,
    :formato_nombre ], if: :persisted?

  friendly_id :fecha_lugar_formato, use: :slugged

  validates_presence_of :fecha, :formato, :organizador, :tienda

  accepts_nested_attributes_for :inscripciones,
    allow_destroy: true, reject_if: :all_blank

  delegate :nombre, to: :formato, allow_nil: true, prefix: true
  delegate :nombre, to: :tienda, allow_nil: true, prefix: true

  def lugar=(nombre)
    self.tienda = Tienda.find_or_initialize_by_nombre(nombre) do |tienda|
      tienda.direccion = direccion
    end
  end

  def lugar
    tienda.try :nombre
  end

  private

    def fecha_lugar_formato
      [fecha, tienda_nombre, formato_nombre].join('-')
    end
end
