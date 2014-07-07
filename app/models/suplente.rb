# encoding: utf-8
class Suplente < Lista
  belongs_to :mazo, inverse_of: :suplente, touch: true
  has_one :principal, through: :mazo
  has_many :demonios, through: :mazo

  validates_presence_of :mazo

  before_validation :nombrar

  delegate :usuario_id, to: :mazo, allow_nil: true

  # TODO revisar si se puede cambiar a nombre
  friendly_id :nombrar, use: :slugged

  amoeba do
    nullify :nombre
    nullify :mazo_id
  end

  private

    def nombrar
      self.nombre = [
        mazo.try(:usuario_id), mazo.try(:nombre), :suplente
      ].join(' ').parameterize
    end
end
