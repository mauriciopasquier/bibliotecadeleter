class CreateTiendas < ActiveRecord::Migration
  def change
    create_table :tiendas do |t|
      t.string :nombre, null: false
      t.string :direccion

      t.timestamps
    end

    add_index "tiendas", ["nombre"], name: "index_tiendas_on_nombre",
      unique: true
  end
end
