class AgregarIndexDeMazoId < ActiveRecord::Migration
  def change
    add_index :listas, ["mazo_id"], name: "index_listas_on_mazo_id"
  end
end
