class CreateVersiones < ActiveRecord::Migration
  def change
    create_table :versiones do |t|
      t.text :texto
      t.string :tipo
      t.string :supertipo
      t.string :subtipo
      t.integer :fue
      t.integer :res
      t.string :senda
      t.text :ambientacion
      t.integer :numero
      t.string :rareza
      t.integer :coste

      t.timestamps
    end
  end
end
