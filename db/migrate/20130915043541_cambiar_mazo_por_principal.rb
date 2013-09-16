class CambiarMazoPorPrincipal < ActiveRecord::Migration

  class Principal < Lista; end
  class Mazo < Lista; end

  def up
    Lista.where(type: 'Mazo').update_all(type: 'Principal')
  end

  def down
    Lista.where(type: 'Principal').update_all(type: 'Mazo')
  end
end
