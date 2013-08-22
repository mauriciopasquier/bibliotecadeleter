class AddPublicaToListas < ActiveRecord::Migration
  def change
    add_column :listas, :publica, :boolean, default: true
  end
end
