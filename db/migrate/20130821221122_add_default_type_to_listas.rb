class AddDefaultTypeToListas < ActiveRecord::Migration
  def up
    change_column_default :listas, :type, 'Lista'
  end

  def down
    change_column_default :listas, :type, nil
  end
end
