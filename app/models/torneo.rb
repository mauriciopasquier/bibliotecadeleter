class Torneo < ActiveRecord::Base
  include FriendlyId
  include PgSearch

  belongs_to :tienda
  belongs_to :organizador, class_name: 'Usuario'
  belongs_to :formato

  # TODO :restrict_with_exception con rails4
  has_many :inscripciones, dependent: :restrict, inverse_of: :torneo do
    def posiciones
      joins(:rondas).group('inscripciones.id').con_puntaje
    end

    def posiciones_en(ronda)
      joins(:rondas).where(
        'rondas.numero <= ?', ronda
      ).group('inscripciones.id').con_puntaje
    end
  end

  has_many :usuarios, through: :inscripciones
  has_many :rondas, through: :inscripciones, order: :numero,
    inverse_of: :torneo
  # TODO congelar los mazos en Inscripcion?
  # has_many :mazos, through: :inscripciones

  multisearchable against: [ :fecha, :direccion, :tienda_nombre,
    :formato_nombre ], if: :persisted?

  friendly_id :fecha_lugar_formato, use: :slugged

  # TODO jugado => propuesto => [ sancionado o rechazado]
  state_machine :estado, initial: :abierto do
    event :cerrar do
      transition :abierto => :cerrado
    end

    event :empezar do
      transition [ :abierto, :cerrado, :jugando ] => :jugando
    end

    event :puntuar do
      transition :jugando => :jugado, unless: :quedan_rondas?
      transition :jugando => same
    end

    event :abrir do
      transition [ :abierto, :cerrado, :jugando ] => :abrir
    end

    event :deshacer do
      transition :jugando => same, if: :quedan_rondas?
      transition :jugando => :cerrado
      transition :jugado => :jugando
    end

    before_transition on: :puntuar, do: :asignar_puntos
    before_transition on: :abrir, do: :deshacer_rondas
    before_transition on: :deshacer, do: :deshacer_ultima_ronda

    state :propuesto do
      validate :cantidad_de_inscriptos
    end
  end

  validates_presence_of :fecha, :formato, :organizador, :tienda

  accepts_nested_attributes_for :inscripciones,
    allow_destroy: true, reject_if: :all_blank

  delegate :nombre, to: :formato, allow_nil: true, prefix: true
  delegate :nombre, to: :tienda, allow_nil: true, prefix: true
  delegate :posiciones, :posiciones_en, to: :inscripciones, allow_nil: true

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
    @sistema ||= SistemaSuizo.new(inscripciones, false)
  end

  def ultima_ronda
    rondas.pluck(:numero).last || 0
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

    def asignar_puntos
      inscripciones.each { |i| i.puntuar ultima_ronda }
    end

    def deshacer_rondas
      rondas.each { |r| r.destroy }
    end

    def deshacer_ultima_ronda
      inscripciones.where(dropeo: ultima_ronda).update_all(dropeo: nil)
      rondas.where(numero: ultima_ronda).destroy_all
    end
end
