class IndicesFaltantes < ActiveRecord::Migration
  def up
    add_index "listas", ["usuario_id"], :name => "index_listas_on_usuario_id"
    add_index "mazos", ["usuario_id"], :name => "index_mazos_on_usuario_id"

    add_index "slots", ["inventario_id", "inventario_type"], :name => "index_slots_on_inventario_id_and_inventario_type"

    add_index "slots", ["version_id"], :name => "index_slots_on_version_id"
    add_index "usuarios", ["codigo"], :name => "index_usuarios_on_codigo", :unique => true
  end

  def down
    remove_index :listas, [:usuario_id]
    remove_index :mazos, [:usuario_id]

    remove_index :slots, [:inventario_id, :inventario_type]
    remove_index :slots, [:version_id]

    remove_index :usuarios, [:codigo]
  end
end
