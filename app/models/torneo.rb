class Torneo < ActiveRecord::Base
  include PgSearch

  belongs_to :tienda
  belongs_to :organizador, class_name: 'Usuario'
  belongs_to :formato

  multisearchable against: [ :fecha, :direccion, :nombre_tienda,
    :nombre_formato ], if: :persisted?

  validates_presence_of :fecha, :formato, :organizador, :tienda

  delegate :nombre, to: :formato, allow_nil: true, prefix: true
  delegate :nombre, to: :tienda, allow_nil: true, prefix: true

  def lugar=(nombre)
    self.tienda = Tienda.find_or_initialize_by_nombre(nombre) do |tienda|
      tienda.direccion = direccion
    end
  end

  def lugar
    tienda.try :nombre
  end
end
