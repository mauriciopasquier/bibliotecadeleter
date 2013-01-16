class AddSlugToArtistas < ActiveRecord::Migration
  def up
    add_column :artistas, :slug, :string
    Artista.find_each(&:save)
    change_column :artistas, :slug, :string, null: false

    add_index :artistas, ["slug"], name: "index_artistas_on_slug", unique: true
  end

  def down
    remove_index :artistas, name: "index_artistas_on_slug"
    remove_column :artistas, :slug
  end
end
