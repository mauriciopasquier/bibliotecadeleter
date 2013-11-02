class AddEstadoToTorneo < ActiveRecord::Migration
  def up
    add_column :torneos, :estado, :string

    Torneo.scoped.update_all(estado: 'abierto')

    change_column :torneos, :estado, :string, null: false
  end

  def down
    remove_column :torneos, :estado
  end
end
