class AddAdjuntoFalsoToImagen < ActiveRecord::Migration
  def self.up
    change_table :imagenes do |t|
      t.attachment :archivo2
    end
  end

  def self.down
    remove_attachment :imagenes, :archivo2
  end
end
