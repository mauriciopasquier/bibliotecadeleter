class AddTipoToFormatos < ActiveRecord::Migration
  def change
    add_column :formatos, :tipo, :string, default: 'Abierto'
  end
end
