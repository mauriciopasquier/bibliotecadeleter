class AddSlugToVersion < ActiveRecord::Migration
  def change
    add_column :versiones, :slug, :string, null: false
  end
end
