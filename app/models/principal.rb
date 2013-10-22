# encoding: utf-8
class Principal < Lista
  belongs_to :mazo, inverse_of: :principal, touch: true
  has_one :suplente, through: :mazo
  has_many :demonios, through: :mazo

  validates_presence_of :mazo

  before_validation :nombrar

  delegate :usuario_id, to: :mazo, allow_nil: true

  friendly_id :nombrar, use: :slugged

  amoeba do
    nullify :nombre
    nullify :mazo_id
  end

  private

    def nombrar
      self.nombre = [
        mazo.try(:usuario_id), mazo.try(:nombre), :principal
      ].join(' ').parameterize
    end
end
