class ChangeDropearEnInscripciones < ActiveRecord::Migration
  def up
    remove_column :inscripciones, :dropeo
    add_column :inscripciones, :dropeo, :integer
  end

  def down
    remove_column :inscripciones, :dropeo
    add_column :inscripciones, :dropeo, :boolean, default: :false
  end
end
