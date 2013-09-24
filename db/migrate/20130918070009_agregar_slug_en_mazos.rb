class AgregarSlugEnMazos < ActiveRecord::Migration
  def up
    add_column :mazos, :slug, :string
  end

  def down
    remove_column :mazos, :slug
  end
end
