# encoding: utf-8
class Slot < ActiveRecord::Base
  attr_accessible :version, :inventario, :inventario_id, :inventario_type,
    :cantidad, :version_id

  belongs_to :version
  belongs_to :inventario, polymorphic: true

  # Restar las cantidades de los slots de `otra` lista de los slots de las
  # demás
  def self.menos(otra)
    select("version_id, sum(#{negar(otra)}) as cantidad").group(:version_id)
  end

  # asociaciones polimórficas con STI
  def inventario_type=(tipo)
     super(tipo.to_s.classify.constantize.base_class.to_s)
  end

  private

    # TODO Funciona en postgresql. Testear con otras DB
    # Para la sumatoria
    def self.negar(lista)
      "case
        when inventario_id = #{lista.id} then (cantidad * -1)
      else
        cantidad
      end"
    end
end
