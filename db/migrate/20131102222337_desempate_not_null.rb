class DesempateNotNull < ActiveRecord::Migration
  def up
    Inscripcion.find_each { |i| i.send(:desempatar) && i.save }
    change_column :inscripciones, :desempate, :integer, null: false
  end

  def down
    change_column :inscripciones, :desempate, :integer
  end
end
