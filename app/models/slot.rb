class Slot < ActiveRecord::Base
  attr_accessible :version, :inventario, :cantidad

  belongs_to :version
  belongs_to :inventario, polymorphic: true
end
