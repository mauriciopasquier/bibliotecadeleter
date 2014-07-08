class Torneo < ActiveRecord::Base
  include FriendlyId
  include PgSearch

  belongs_to :tienda
  belongs_to :organizador, class_name: 'Usuario'
  belongs_to :formato

  has_many :inscripciones, dependent: :restrict_with_error,
    inverse_of: :torneo do
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
  has_many :rondas, -> { order(:numero) }, through: :inscripciones,
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
      transition [ :abierto, :cerrado, :jugando ] => :abierto
    end

    event :deshacer do
      transition :jugando => same, unless: :primera_ronda?
      transition :jugando => :cerrado
      transition :jugado => :jugando
    end

    event :reportar do
      transition :jugado => :reportado
    end

    event :sancionar do
      transition :reportado => :oficial
    end

    event :rechazar do
      transition :reportado=> :jugado
    end

    before_transition on: :puntuar, do: :asignar_puntos
    before_transition on: :abrir, do: :deshacer_rondas
    before_transition on: :deshacer, do: :deshacer_ultima_ronda

    state :reportado do
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

  def self.estados
    state_machines[:estado].states.collect &:human_name
  end

  # Permite cargar una tienda nueva por el nombre desde el torneo mismo.
  def lugar=(nombre)
    self.tienda = Tienda.find_or_initialize_by(nombre: nombre) do |tienda|
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

    def primera_ronda?
      ultima_ronda == 1
    end

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

    def should_generate_new_friendly_id?
      fecha_changed? || super
    end
end
