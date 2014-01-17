# encoding: utf-8
class Slot < ActiveRecord::Base
  belongs_to :version
  belongs_to :inventario, polymorphic: true

  validates_presence_of :version_id

  amoeba do
    nullify :inventario_id
  end

  # Restar las cantidades de los slots de `otra` lista de los slots de las
  # demás
  def self.menos(otra)
    select("version_id, sum(#{negar(otra)}) as cantidad").group(:version_id)
  end

  # asociaciones polimórficas con STI
  def inventario_type=(tipo)
     super(tipo.to_s.classify.constantize.base_class.to_s)
  end

  def self.contados
    joins(:version).select(
      'versiones.*, slots.*').order(
        'versiones.tipo, versiones.coste_convertido')
  end

  private

    # Para la sumatoria
    def self.negar(lista)
      "case
        when inventario_id = #{lista.id} then (cantidad * -1)
      else
        cantidad
      end"
    end
end
