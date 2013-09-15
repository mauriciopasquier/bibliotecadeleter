class AddUsuarioToMazo < ActiveRecord::Migration
  def change
    add_column :mazos, :usuario_id, :integer
  end
end
