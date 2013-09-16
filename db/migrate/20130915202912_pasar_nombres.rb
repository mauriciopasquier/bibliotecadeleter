class PasarNombres < ActiveRecord::Migration
  def up
    Mazo.all.each do |m|
      m.update_attribute(:nombre, m.principal.nombre)
      m.principal.update_attribute(:nombre, m.principal.uuid)
    end
  end

  def down
    Mazo.all.each do |m|
      m.principal.update_attribute(:nombre, m.nombre)
    end
  end
end
