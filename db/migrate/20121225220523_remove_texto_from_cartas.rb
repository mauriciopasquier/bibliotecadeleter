class RemoveTextoFromCartas < ActiveRecord::Migration
  def up
    remove_column :cartas, :texto
  end

  def down
    add_column :cartas, :texto, :text
  end
end
