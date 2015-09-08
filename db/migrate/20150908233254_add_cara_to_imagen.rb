class AddCaraToImagen < ActiveRecord::Migration
  def change
    add_column :imagenes, :cara, :boolean, default: true
  end
end
