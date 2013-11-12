class RemoverEstadosViejosDeTorneos < ActiveRecord::Migration
  def up
    change_table :torneos do |t|
      t.remove  "oficial"
      t.remove  "jugado"
    end
  end

  def down
    change_table :torneos do |t|
      t.boolean  "oficial",        :default => false
      t.boolean  "jugado",         :default => false
    end
  end
end
