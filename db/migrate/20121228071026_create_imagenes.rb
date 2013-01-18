class CreateImagenes < ActiveRecord::Migration
  def change
    create_table :imagenes do |t|
      t.references :version

      t.timestamps
    end
  end
end
