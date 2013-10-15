class CreateJoinTableCartasFormatos < ActiveRecord::Migration
  def change
    create_table "cartas_formatos", :id => false, :force => true do |t|
      t.integer "carta_id"
      t.integer "formato_id"
    end

    add_index "cartas_formatos", ["carta_id"], :name => "index_cartas_formatos_on_carta_id"
    add_index "cartas_formatos", ["formato_id"], :name => "index_cartas_formatos_on_formato_id"
  end
end
