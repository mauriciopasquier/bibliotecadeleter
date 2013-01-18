class VersionesHasAndBelongsToManyArtistas < ActiveRecord::Migration
  def up
    create_table :artistas_versiones, id: false, force: true do |t|
      t.integer "artista_id"
      t.integer "version_id"
    end

    remove_column :versiones, :artista_id
  end

  def down
    add_column :versiones, :artista_id, :integer

    drop_table :artistas_versiones
  end
end
