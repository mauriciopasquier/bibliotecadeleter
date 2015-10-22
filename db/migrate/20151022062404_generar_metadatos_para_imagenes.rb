class GenerarMetadatosParaImagenes < ActiveRecord::Migration
  def up
    Imagen.find_each do |i|
      i.guardar_metadatos_de_archivos!
      i.save!
    end
  end

  def down
    Imagen.find_each { |i| i.update_attribute :metadatos, {} }
  end
end
