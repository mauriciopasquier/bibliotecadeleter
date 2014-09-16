class CreateStaffJoinTable < ActiveRecord::Migration
  def change
    create_join_table :tiendas, :usuarios do |t|
      t.index [:usuario_id, :tienda_id], unique: true
    end
  end
end
