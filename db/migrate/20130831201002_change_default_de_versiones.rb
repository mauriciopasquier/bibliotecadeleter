class ChangeDefaultDeVersiones < ActiveRecord::Migration
  def up
    change_table :versiones do |t|
      %w{ texto tipo supertipo subtipo senda ambientacion rareza
      }.each { |columna| t.change_default columna, nil }
    end
  end

  def down
    change_table :versiones do |t|
      %s{ texto tipo supertipo subtipo senda ambientacion rareza
      }.each { |columna| t.change_default columna, '' }
    end
  end
end
