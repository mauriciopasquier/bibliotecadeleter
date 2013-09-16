# encoding: utf-8
class Principal < Lista
  has_one :mazo, inverse_of: :suplente
  has_one :suplente, through: :mazo

  # Porque estoy usando el belongs_to como parent?
  after_save :touch_mazo

  private

    def touch_mazo
      self.mazo.touch
    end
end
