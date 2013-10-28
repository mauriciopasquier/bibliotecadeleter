class Inscripcion < ActiveRecord::Base
  belongs_to :torneo
  belongs_to :usuario, foreign_key: :codigo, primary_key: :codigo
  has_many :rondas

  validates_presence_of :torneo, :codigo, :participante

  accepts_nested_attributes_for :rondas, reject_if: :all_blank

  normalize_attributes :codigo, :participante

  def puntos
   rondas.sum(:puntos)
  end

  def partidas_ganadas
   rondas.sum(:partidas_ganadas)
  end
end
