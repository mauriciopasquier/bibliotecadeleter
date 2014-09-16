class Tienda < ActiveRecord::Base
  validates_presence_of :nombre
  validates_uniqueness_of :nombre
  validates_inclusion_of :region, in: Region.all

  has_many :torneos, inverse_of: :tienda
  has_many :links, as: :linkeable, dependent: :destroy
  has_and_belongs_to_many :usuarios

  slugs_dependientes_en :torneos, dependencias: :nombre
end
