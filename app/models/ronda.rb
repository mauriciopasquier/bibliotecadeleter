class Ronda < ActiveRecord::Base
  belongs_to :inscripcion
  belongs_to :oponente, class_name: 'Inscripcion'
end
