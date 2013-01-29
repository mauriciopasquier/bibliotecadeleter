# encoding: UTF-8
class AddIndicesToVarios < ActiveRecord::Migration
  def change
    # No uso un índice compuesto porque no se suele restringir en las 2
    # columnas simultáneamente, y en Postgresql recomiendan apegarse a los
    # índices simples.
    add_index :artistas_imagenes, :artista_id
    add_index :artistas_imagenes, :imagen_id

    add_index :imagenes, :version_id

    add_index :links, [ :linkeable_id, :linkeable_type ]

    add_index :usuarios, :nick, unique: true

    add_index :versiones, :carta_id
    add_index :versiones, :expansion_id
  end
end
