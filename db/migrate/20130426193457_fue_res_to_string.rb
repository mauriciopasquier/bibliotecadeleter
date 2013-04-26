class FueResToString < ActiveRecord::Migration
  def up
    change_column :versiones, :fue, :string
    change_column :versiones, :res, :string
  end

  def down
    change_column :versiones, :fue, :integer
    change_column :versiones, :res, :integer
  end
end
