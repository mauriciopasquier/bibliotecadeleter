class GenerarSlugsEnMazos < ActiveRecord::Migration
  def up
    Mazo.find_each(&:save)
    change_column :mazos, :slug, :string, null: false

    add_index :mazos, ["slug"], name: "index_mazos_on_slug"
  end

  def down
    remove_index :mazos, name: "index_mazos_on_slug"
  end
end
