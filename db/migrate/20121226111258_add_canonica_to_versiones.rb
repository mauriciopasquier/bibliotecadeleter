class AddCanonicaToVersiones < ActiveRecord::Migration
  def change
    add_column :versiones, :canonica, :boolean, default: false
  end
end
