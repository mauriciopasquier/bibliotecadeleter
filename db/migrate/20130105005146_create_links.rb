class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.references :linkeable, polymorphic: true

      t.timestamps
    end
  end
end
