class CambiarVisibilidadEnListas < ActiveRecord::Migration
  def up
    Lista.where(type: [ 'Reserva', 'Coleccion']).update_all(publica: false)
  end

  def down
    Lista.where(type: [ 'Reserva', 'Coleccion']).update_all(publica: true)
  end
end
