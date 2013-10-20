class AddNotasToMazos < ActiveRecord::Migration
  def change
    add_column :mazos, :notas, :text
  end
end
