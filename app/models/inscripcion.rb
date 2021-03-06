class Inscripcion < ActiveRecord::Base
  belongs_to :torneo, inverse_of: :inscripciones
  belongs_to :usuario, foreign_key: :codigo, primary_key: :codigo
  has_many :rondas, inverse_of: :inscripcion

  validates_presence_of :torneo, :codigo, :participante

  accepts_nested_attributes_for :rondas, reject_if: :all_blank

  before_create :desempatar

  normalize_attributes :codigo, :participante

  def self.posicionadas
    joins(:rondas).group('inscripciones.id').select(
      'inscripciones.*,
      sum(rondas.puntos) as puntaje,
      sum(rondas.partidas_ganadas) as partidas'
    ).order('puntaje desc, partidas desc, desempate desc')
  end

  def puntos
   rondas.sum(:puntos)
  end

  def partidas_ganadas
   rondas.sum(:partidas_ganadas)
  end

  def partidas_ganadas_en(ronda)
    rondas.where(numero: ronda).first.try(:partidas_ganadas) || 0
  end

  def ha_jugado_con?(inscripcion)
    rondas.where(oponente_id: inscripcion.id).any?
  end

  def bye?
    false
  end

  def dropear_o_deshacer
    self.dropeo = dropeo? ? nil : torneo.ultima_ronda
    dropeo?
  end

  def puntuar(ronda)
    rondas.where(numero: ronda).first.try(:puntuar)
  end

  private

    def desempatar
      self.desempate = rand(10000)
    end
end
