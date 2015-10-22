class AddGeometriaToImagenes < ActiveRecord::Migration
  def change
    add_column :imagenes, :metadatos, :hstore, default: {}
  end
end
