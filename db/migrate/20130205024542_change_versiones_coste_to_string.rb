class ChangeVersionesCosteToString < ActiveRecord::Migration
  def up
    remove_column :versiones, :coste
    add_column :versiones, :coste, :string
  end

  def down
    remove_column :versiones, :coste
    add_column :versiones, :coste, :integer
  end
end
