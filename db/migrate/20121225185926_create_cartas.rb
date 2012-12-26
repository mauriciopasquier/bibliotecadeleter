class CreateCartas < ActiveRecord::Migration
  def change
    create_table :cartas do |t|
      t.string :nombre, null: false
      t.text :texto

      t.timestamps
    end
  end
end
