class AddFormatoObjetivoToMazos < ActiveRecord::Migration
  def change
    add_column :mazos, :formato_objetivo, :integer
  end
end
