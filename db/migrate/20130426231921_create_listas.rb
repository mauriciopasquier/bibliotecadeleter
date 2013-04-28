class CreateListas < ActiveRecord::Migration
  def change
    create_table :listas do |t|
      t.string :nombre, null: false
      t.boolean :coleccion, default: false
      t.references :usuario
      t.timestamps
    end
  end
end
