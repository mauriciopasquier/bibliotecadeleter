class AddAttachmentArchivoToImagenes < ActiveRecord::Migration
  def self.up
    change_table :imagenes do |t|
      t.has_attached_file :archivo
    end
  end

  def self.down
    drop_attached_file :imagenes, :archivo
  end
end
