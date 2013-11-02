class FixJuezPrincipal < ActiveRecord::Migration
  def up
    change_column :torneos, :juez_principal, :string
  end

  def down
    change_column :torneos, :juez_principal, :integer
  end
end
