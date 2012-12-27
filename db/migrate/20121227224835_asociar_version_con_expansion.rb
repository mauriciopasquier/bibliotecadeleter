class AsociarVersionConExpansion < ActiveRecord::Migration
  def up
    add_column :versiones, :expansion_id, :integer
  end

  def down
    remove_column :versiones, :expansion_id
  end
end
