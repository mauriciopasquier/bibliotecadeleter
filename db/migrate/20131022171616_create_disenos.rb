class CreateDisenos < ActiveRecord::Migration
  def change
    create_table :disenos do |t|
      t.string    "nombre", null: false
      t.text      "texto"
      t.string    "tipo"
      t.string    "supertipo"
      t.string    "subtipo"
      t.string    "fue"
      t.string    "res"
      t.string    "senda"
      t.text      "ambientacion"
      t.text      "fundamento", null: false
      t.string    "slug",       null: false
      t.string    "coste"
      t.integer   "coste_convertido"
      t.references :usuario

      t.timestamps
    end
  end
end
