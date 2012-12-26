class CreateVersiones < ActiveRecord::Migration
  def change
    create_table :versiones do |t|
      t.text :texto, default: ''
      t.string :tipo, default: ''
      t.string :supertipo, default: ''
      t.string :subtipo, default: ''
      t.integer :fue
      t.integer :res
      t.string :senda, default: ''
      t.text :ambientacion, default: ''
      t.integer :numero
      t.string :rareza, default: ''
      t.integer :coste

      t.timestamps
    end
  end
end
