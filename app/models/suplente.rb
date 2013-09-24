# encoding: utf-8
class Suplente < Lista
  has_one :mazo, inverse_of: :suplente, autosave: true
  has_one :principal, through: :mazo

  # Porque estoy usando el belongs_to como parent?
  after_save :touch_mazo

  private

    def touch_mazo
      self.mazo.touch
    end
end
