class VersionBelongsToArtista < ActiveRecord::Migration
  def change
    add_column :versiones, :artista_id, :integer
  end
end
