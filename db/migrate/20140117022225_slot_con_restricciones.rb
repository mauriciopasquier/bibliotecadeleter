class SlotConRestricciones < ActiveRecord::Migration
  def up
    change_column :slots, :inventario_id, :integer, null: false
    change_column :slots, :version_id, :integer, null: false
  end

  def down
    change_column :slots, :inventario_id, :integer, null: true
    change_column :slots, :version_id, :integer, null: true
  end
end
