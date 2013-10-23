class Torneo < ActiveRecord::Base
  belongs_to :tienda
  belongs_to :organizador, class_name: 'Usuario'
  belongs_to :formato

  validates_presence_of :fecha, :formato, :organizador, :tienda

  def lugar=(nombre)
    self.tienda = Tienda.find_or_initialize_by_nombre(nombre) do |tienda|
      tienda.direccion = direccion
    end
  end

  def lugar
    tienda.try :nombre
  end
end
