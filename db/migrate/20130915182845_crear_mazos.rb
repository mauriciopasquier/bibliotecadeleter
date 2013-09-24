require 'yaml'

class CrearMazos < ActiveRecord::Migration

  class Lista < ActiveRecord::Base; end
  class Principal < Lista; end

  class Mazo < ActiveRecord::Base
    has_many :slots, as: :inventario
  end

  def up
    create_table "mazos" do |t|
      t.integer  "principal_id"
      t.integer  "suplente_id"
      t.string   "formato"
      t.timestamps
    end

    Lista.where(type: 'Principal').each do |m|
      nuevo = Mazo.create do |mazo|
        mazo.principal_id = m.id
      end
      if m.data.present?
        data = YAML.load(m.data)

        if data['demonio_id'].present?
          nuevo.slots.create(cantidad: 1, version_id: data['demonio_id'])
        end

        nuevo.update_attribute(:formato, data['formato'])
        m.update_attribute(:data, nil)
      end
    end
  end

  def down
    drop_table :mazos
  end
end
