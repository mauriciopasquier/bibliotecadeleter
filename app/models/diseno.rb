class Diseno < ActiveRecord::Base
  belongs_to :usuario

  validates_presence_of :nombre, :fundamento
end
