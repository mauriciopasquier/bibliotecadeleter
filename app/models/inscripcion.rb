class Inscripcion < ActiveRecord::Base
  belongs_to :torneo
  belongs_to :usuario, foreign_key: :codigo, primary_key: :codigo

  validates_presence_of :torneo, :codigo, :participante

  normalize_attributes :codigo, :participante
end
