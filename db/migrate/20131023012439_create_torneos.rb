class CreateTorneos < ActiveRecord::Migration
  def change
    create_table :torneos do |t|
      t.date :fecha, null: false
      t.integer :tienda_id, null: false
      t.string :direccion
      t.integer :formato_id, null: false
      t.integer :organizador_id, null: false
      t.integer :juez_principal

      t.timestamps
    end

    add_index "torneos", ["fecha"], name: "index_torneos_on_fecha"
    add_index "torneos", ["organizador_id"], name: "index_torneos_on_organizador_id"
    add_index "torneos", ["tienda_id"], name: "index_torneos_on_tienda_id"
  end
end
