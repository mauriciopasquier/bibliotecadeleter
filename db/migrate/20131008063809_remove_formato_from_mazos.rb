class RemoveFormatoFromMazos < ActiveRecord::Migration
  def up
    remove_column :mazos, :formato
  end

  def down
    add_column :mazos, :formato, :string
  end
end
