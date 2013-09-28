class AumentarEspacioParaCodigo < ActiveRecord::Migration
  def up
    change_column :usuarios, :codigo, :string
  end

  def down
    remove_column :usuarios, :codigo
    add_column :usuarios, :codigo, :integer
  end
end
