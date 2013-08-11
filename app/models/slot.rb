class Slot < ActiveRecord::Base
  attr_accessible :inventariable, :inventario, :cantidad

  belongs_to :inventariable, polymorphic: true
  belongs_to :inventario, polymorphic: true
end
