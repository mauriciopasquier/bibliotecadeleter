class AddOficialToTorneos < ActiveRecord::Migration
  def change
    add_column :torneos, :oficial, :boolean, default: false
  end
end
