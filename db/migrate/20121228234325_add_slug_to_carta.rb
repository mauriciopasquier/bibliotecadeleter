class AddSlugToCarta < ActiveRecord::Migration
  def change
    add_column :cartas, :slug, :string, null: false

    add_index "cartas", ["slug"], name: "index_cartas_on_slug", unique: true
  end
end
