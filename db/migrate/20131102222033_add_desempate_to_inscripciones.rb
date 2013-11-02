class AddDesempateToInscripciones < ActiveRecord::Migration
  def change
    add_column :inscripciones, :desempate, :integer
  end
end
