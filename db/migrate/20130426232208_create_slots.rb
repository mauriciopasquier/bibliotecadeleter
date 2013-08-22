class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.references :carta
      t.references :lista
      t.integer :cantidad

      t.timestamps
    end
  end
end
