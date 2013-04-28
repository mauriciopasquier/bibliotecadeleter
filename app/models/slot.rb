class Slot < ActiveRecord::Base
  attr_accessible :carta, :lista, :cantidad

  belongs_to :carta
  belongs_to :lista
end
