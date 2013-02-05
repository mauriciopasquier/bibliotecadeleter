class AddCosteConvertidoToVersiones < ActiveRecord::Migration
  def change
    add_column :versiones, :coste_convertido, :integer
  end
end
