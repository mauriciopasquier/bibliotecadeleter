class ScopearSlugsEnCartas < ActiveRecord::Migration
  def up
    remove_index "cartas", name: "index_cartas_on_slug"
  end

  def down
    add_index "cartas", ["slug"], :name => "index_cartas_on_slug", :unique => true
  end
end
