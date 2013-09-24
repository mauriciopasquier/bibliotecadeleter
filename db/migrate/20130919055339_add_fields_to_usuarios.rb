class AddFieldsToUsuarios < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :sash_id, :integer
    add_column :usuarios, :level, :integer, :default => 0
  end

  def self.down
    remove_column :usuarios, :sash_id
    remove_column :usuarios, :level
  end
end
