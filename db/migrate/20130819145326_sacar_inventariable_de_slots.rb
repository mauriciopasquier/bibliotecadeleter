class SacarInventariableDeSlots < ActiveRecord::Migration
  def up
    change_table :slots do |t|
      t.remove :inventariable_type
      t.remove :inventariable_id
      t.references :version
    end
  end

  def down
    change_table :slots do |t|
      t.string :inventariable_type
      t.integer :inventariable_id
      t.remove :version_id
    end
  end
end
