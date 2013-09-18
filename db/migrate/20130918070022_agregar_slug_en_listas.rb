class AgregarSlugEnListas < ActiveRecord::Migration
  def up
    add_column :listas, :slug, :string
  end

  def down
    remove_column :listas, :slug
  end
end
