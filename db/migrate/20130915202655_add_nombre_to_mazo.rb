class AddNombreToMazo < ActiveRecord::Migration
  def change
    add_column :mazos, :nombre, :string
  end
end
