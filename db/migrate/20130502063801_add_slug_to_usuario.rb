class AddSlugToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :slug, :string
    add_index "usuarios", ["slug"], name: "index_usuarios_on_slug", unique: true

    Usuario.find_each(&:save)
  end
end
