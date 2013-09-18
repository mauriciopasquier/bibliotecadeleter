class GenerarSlugsEnListas < ActiveRecord::Migration
  def up
    Lista.find_each(&:save)
    change_column :listas, :slug, :string, null: false

    add_index :listas, ["slug"], name: "index_listas_on_slug"
  end

  def down
    remove_index :listas, name: "index_listas_on_slug"
  end
end
