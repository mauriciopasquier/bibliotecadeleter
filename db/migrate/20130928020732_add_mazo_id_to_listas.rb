class AddMazoIdToListas < ActiveRecord::Migration
  def change
    add_column :listas, :mazo_id, :integer
  end
end
