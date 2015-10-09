class RemoveAdjuntoFalsoFromImagen < ActiveRecord::Migration
  def up
    remove_attachment :imagenes, :archivo2
  end

  def down
    change_table :imagenes do |t|
      t.attachment :archivo2
    end
  end
end
