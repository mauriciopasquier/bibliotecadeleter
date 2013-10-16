class AddReglasToFormato < ActiveRecord::Migration
  def change
    add_column :formatos, :demonios,        :integer, default: 1
    add_column :formatos, :principal,       :integer, default: 50
    add_column :formatos, :suplente,        :integer, default: 12
    add_column :formatos, :copias,          :integer, default: 4
    add_column :formatos, :limitar_sendas,  :boolean, default: true
  end
end
