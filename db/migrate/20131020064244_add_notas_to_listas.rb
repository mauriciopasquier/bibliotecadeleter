class AddNotasToListas < ActiveRecord::Migration
  def change
    add_column :listas, :notas, :text
  end
end
