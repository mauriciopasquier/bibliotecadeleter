class DeshacerCambiosDeSlugEnCartas < ActiveRecord::Migration
  def up
    add_index "cartas", ["slug"], :name => "index_cartas_on_slug", :unique => true
  end

  def down
    remove_index "cartas", name: "index_cartas_on_slug"
  end
end
