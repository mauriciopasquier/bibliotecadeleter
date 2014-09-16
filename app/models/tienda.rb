class Tienda < ActiveRecord::Base
  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  has_many :torneos, inverse_of: :tienda
  has_and_belongs_to_many :usuarios

  slugs_dependientes_en :torneos, dependencias: :nombre
end
