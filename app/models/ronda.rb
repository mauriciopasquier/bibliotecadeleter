class Ronda < ActiveRecord::Base
  belongs_to :inscripcion, inverse_of: :rondas
  has_one :torneo, through: :inscripcion
  belongs_to :oponente, class_name: 'Inscripcion'

  validates_presence_of :inscripcion, :numero, :partidas_ganadas

  def puntuar
    self.puntos = case partidas_ganadas <=> oponente.partidas_ganadas_en(numero)
      when 0
        torneo.sistema.class::PUNTOS[:empate]
      when 1
        torneo.sistema.class::PUNTOS[:victoria]
      else
        torneo.sistema.class::PUNTOS[:derrota]
    end
    save
  end
end
