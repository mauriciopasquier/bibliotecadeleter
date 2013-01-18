class CartaTieneMuchasVersiones < ActiveRecord::Migration
  def up
    add_column :versiones, :carta_id, :integer
  end

  def down
    remove_column :versiones, :carta_id
  end
end
