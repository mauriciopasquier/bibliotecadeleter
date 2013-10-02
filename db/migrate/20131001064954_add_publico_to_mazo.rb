class AddPublicoToMazo < ActiveRecord::Migration
  def change
    add_column :mazos, :publico, :boolean, default: true
  end
end
