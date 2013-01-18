class AddSlugToExpansion < ActiveRecord::Migration
  def change
    add_column :expansiones, :slug, :string, null: false

    add_index "expansiones", ["slug"], name: "index_expansiones_on_slug", unique: true
  end
end
