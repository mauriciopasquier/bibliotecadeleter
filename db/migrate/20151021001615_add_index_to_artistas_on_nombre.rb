class AddIndexToArtistasOnNombre < ActiveRecord::Migration
  def change
    add_index :artistas, :nombre, unique: true
  end
end
