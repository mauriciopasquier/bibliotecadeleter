# encoding: utf-8
class Suplente < Lista
  has_one :mazo, inverse_of: :suplente, autosave: true
  has_one :principal, through: :mazo
end
