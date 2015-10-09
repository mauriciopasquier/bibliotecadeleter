class MarcarContracarasEnImagen < ActiveRecord::Migration
  def up
    Version.demonios.collect { |d| d.imagenes }.flatten.select do |i|
      i.archivo_file_name =~ /terrenal/
    end.each do |contracara|
      contracara.update_attribute :cara, false
    end
  end

  def down
    Imagen.update_all cara: true
  end
end
