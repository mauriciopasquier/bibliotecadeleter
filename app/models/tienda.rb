class Tienda < ActiveRecord::Base
  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  has_many :torneos, inverse_of: :tienda

  slugs_dependientes_en :torneos
end
