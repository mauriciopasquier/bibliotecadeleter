class AddConsistenciaVisible < ActiveRecord::Migration
  def up
    rename_column :listas, :publica, :visible
    rename_column :mazos, :publico, :visible
  end

  def down
    rename_column :mazos, :visible, :publico
    rename_column :listas, :visible, :publica
  end
end
