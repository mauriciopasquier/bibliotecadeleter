class Torneo < ActiveRecord::Base
  include FriendlyId
  include PgSearch

  belongs_to :tienda
  belongs_to :organizador, class_name: 'Usuario'
  belongs_to :formato

  # TODO :restrict_with_exception con rails4
  has_many :inscripciones, dependent: :restrict, inverse_of: :torneo do
    def posiciones
      joins(:rondas).group(
        'inscripciones.id'
      ).select(
        'inscripciones.*,
          sum(rondas.puntos) as puntaje,
          sum(rondas.partidas_ganadas) as partidas'
      ).order('puntaje desc, partidas desc')
    end
  end

  has_many :usuarios, through: :inscripciones
  has_many :rondas, through: :inscripciones, order: :numero
  # TODO congelar los mazos en Inscripcion?
  # has_many :mazos, through: :inscripciones

  multisearchable against: [ :fecha, :direccion, :tienda_nombre,
    :formato_nombre ], if: :persisted?

  friendly_id :fecha_lugar_formato, use: :slugged

  validates_presence_of :fecha, :formato, :organizador, :tienda
  validate :cantidad_de_inscriptos,
    if: Proc.new { |torneo| torneo.jugado? && torneo.oficial? }

  accepts_nested_attributes_for :inscripciones,
    allow_destroy: true, reject_if: :all_blank

  delegate :nombre, to: :formato, allow_nil: true, prefix: true
  delegate :nombre, to: :tienda, allow_nil: true, prefix: true
  delegate :posiciones, to: :inscripciones, allow_nil: true

  attr_writer :sistema

  # Permite cargar una tienda nueva por el nombre desde el torneo mismo.
  def lugar=(nombre)
    self.tienda = Tienda.find_or_initialize_by_nombre(nombre) do |tienda|
      tienda.direccion = direccion
    end
  end

  def lugar
    tienda.try :nombre
  end

  def sistema
    @sistema ||= SistemaSuizo.new(inscripciones)
  end

  def ultima_ronda
    rondas.pluck(:numero).last || 0
  end

  def puntuar
    rondas.where(numero: ultima_ronda).map &:puntuar
  end

  def quedan_rondas?
    ultima_ronda < sistema.rondas
  end

  def bye
    Bye.new(self)
  end

  private

    def cantidad_de_inscriptos
      errors.add(:inscripciones, :insuficientes) if inscripciones.size < 8
    end

    def fecha_lugar_formato
      [fecha, tienda_nombre, formato_nombre].join('-')
    end
end
