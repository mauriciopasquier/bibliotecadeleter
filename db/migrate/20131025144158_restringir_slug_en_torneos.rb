class RestringirSlugEnTorneos < ActiveRecord::Migration
  def up
    change_column :torneos, :slug, :string, null: false
  end

  def down
    change_column :torneos, :slug, :string
  end
end
