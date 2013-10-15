class CreateFormatos < ActiveRecord::Migration
  def change
    create_table :formatos do |t|
      t.string :nombre, null: false
      t.string :slug,   null: false
      t.timestamps
    end

    create_table "expansiones_formatos", :id => false, :force => true do |t|
      t.integer "expansion_id"
      t.integer "formato_id"
    end

    add_index "formatos", ["slug"], :name => "index_formatos_on_slug", :unique => true
    add_index "expansiones_formatos", ["expansion_id"], :name => "index_expansiones_formatos_on_expansion_id"
    add_index "expansiones_formatos", ["formato_id"], :name => "index_expansiones_formatos_on_formato_id"
  end
end
