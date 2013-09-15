# encoding: utf-8
class Principal < Lista
  has_one :mazo, inverse_of: :suplente, autosave: true
  has_one :suplente, through: :mazo
end
