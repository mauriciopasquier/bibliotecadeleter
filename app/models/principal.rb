# encoding: utf-8
class Principal < Lista
  has_one :mazo, inverse_of: :principal
  has_one :suplente, through: :mazo

  # Porque estoy usando el belongs_to como parent?
  after_save :touch_mazo

  private

    def touch_mazo
      self.mazo.try(:touch)
    end
end
