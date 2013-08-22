class HacerSlotPolimorfico < ActiveRecord::Migration
  def up
    change_table :slots do |t|
      t.remove  :carta_id
      t.integer :inventariable_id
      t.string  :inventariable_type

      t.remove  :lista_id
      t.integer :inventario_id
      t.string  :inventario_type
    end
  end

  def down
    change_table :slots do |t|
      t.remove  :inventariable_id
      t.remove  :inventariable_type

      t.remove  :inventario_id
      t.remove  :inventario_type

      t.integer :carta_id
      t.integer :lista_id
    end
  end
end
