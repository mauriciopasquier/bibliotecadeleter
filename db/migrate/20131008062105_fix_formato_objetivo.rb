class FixFormatoObjetivo < ActiveRecord::Migration
  def change
    rename_column :mazos, :formato_objetivo, :formato_objetivo_id
  end
end
