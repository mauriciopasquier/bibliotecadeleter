class ImagenHasAndBelongsToManyArtistas < ActiveRecord::Migration
  def up
    drop_table :artistas_versiones

    create_table :artistas_imagenes, :id => false, :force => true do |t|
      t.integer "artista_id"
      t.integer "imagen_id"
    end
  end

  def down
    create_table :artistas_versiones, :id => false, :force => true do |t|
      t.integer "artista_id"
      t.integer "version_id"
    end

    drop_table :artistas_imagenes
  end
end
