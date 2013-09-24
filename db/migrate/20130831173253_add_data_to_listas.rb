class AddDataToListas < ActiveRecord::Migration
  def change
    add_column :listas, :data, :text
  end
end
