class RemoverDataDeListas < ActiveRecord::Migration
  def up
    remove_column :listas, :data
  end

  def down
    add_column :listas, :data, :text
  end
end
