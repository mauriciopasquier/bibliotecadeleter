class AddNombreToLinks < ActiveRecord::Migration
  def change
    add_column :links, :nombre, :string
  end
end
