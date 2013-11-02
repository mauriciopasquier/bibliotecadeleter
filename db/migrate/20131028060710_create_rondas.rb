class CreateRondas < ActiveRecord::Migration
  def change
    create_table :rondas do |t|
      t.integer :numero
      t.references :inscripcion
      t.integer :oponente_id
      t.integer :puntos
      t.integer :partidas_ganadas
      t.timestamps
    end
  end
end
