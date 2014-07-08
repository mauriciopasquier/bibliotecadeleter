class AddCodigoToExpansiones < ActiveRecord::Migration
  def change
    add_column :expansiones, :codigo, :string
  end
end
