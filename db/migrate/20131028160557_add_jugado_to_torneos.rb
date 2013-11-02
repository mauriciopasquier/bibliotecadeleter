class AddJugadoToTorneos < ActiveRecord::Migration
  def change
    add_column :torneos, :jugado, :boolean, default: false
  end
end
