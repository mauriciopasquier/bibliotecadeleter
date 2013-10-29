class AddDropeoToInscripciones < ActiveRecord::Migration
  def change
    add_column :inscripciones, :dropeo, :boolean, default: false
  end
end
