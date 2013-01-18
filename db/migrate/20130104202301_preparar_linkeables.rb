class PrepararLinkeables < ActiveRecord::Migration
  def up
    remove_column :artistas, :web
  end

  def down
    add_column :artistas, :web, :string
  end
end
