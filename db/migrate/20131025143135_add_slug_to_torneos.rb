class AddSlugToTorneos < ActiveRecord::Migration
  def change
    add_column :torneos, :slug, :string

    add_index "torneos", ["slug"], :name => "index_torneos_on_slug"
  end
end
