class ConvertirListaEnSti < ActiveRecord::Migration
  def up
    add_column :listas, :type, :string
    Lista.where(coleccion: true).update_all(type: 'Coleccion')
    Lista.where(coleccion: false).update_all(type: 'Lista')
    remove_column :listas, :coleccion
  end

  def down
    add_column :listas, :coleccion, :boolean, default: false
    Lista.where(type: 'Coleccion').update_all(coleccion: true)
    Lista.where(type: 'Lista').update_all(coleccion: false)
    remove_column :listas, :type
  end
end
