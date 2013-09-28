class RemoverReferenciasDeMazo < ActiveRecord::Migration
  def up
    change_table :mazos do |t|
      t.remove :suplente_id
      t.remove :principal_id
    end
  end

  def down
    change_table :mazos do |t|
      t.integer :suplente_id
      t.integer :principal_id
    end
  end
end
