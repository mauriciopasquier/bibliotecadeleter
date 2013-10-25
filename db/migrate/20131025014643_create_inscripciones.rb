class CreateInscripciones < ActiveRecord::Migration
  def change
    create_table :inscripciones do |t|
      t.string :participante, null: false
      t.string :codigo, null: false
      t.integer :torneo_id, null: false

      t.timestamps
    end
  end
end
