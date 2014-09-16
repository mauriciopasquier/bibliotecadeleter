class AddRegionToTienda < ActiveRecord::Migration
  def change
    add_column :tiendas, :region, :string
  end
end
