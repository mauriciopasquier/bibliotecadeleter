class AddCodigoToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :codigo, :integer
  end
end
