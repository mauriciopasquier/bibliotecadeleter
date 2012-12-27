class CreateExpansiones < ActiveRecord::Migration
  def change
    create_table :expansiones do |t|
      t.string :nombre, null: false
      t.date :lanzamiento
      t.date :presentacion
      t.text :notas
      t.string :saga
      t.integer :total

      t.timestamps
    end
  end
end
