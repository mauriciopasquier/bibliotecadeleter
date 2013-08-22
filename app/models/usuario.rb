# encoding: utf-8
class Usuario < ActiveRecord::Base
  include FriendlyId
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :nick, :codigo

  has_many :links, as: :linkeable, dependent: :destroy
  has_many :listas, dependent: :destroy
  has_one :coleccion, dependent: :destroy
  has_one :reserva, dependent: :destroy

  friendly_id :nick, use: :slugged

  after_create :crear_listas

  # Cartas que le faltan (cantidades negativas) o sobran a este usuario
  def lista_de_cambio
    self.coleccion.comparar_con self.reserva
  end

  def faltantes
    self.lista_de_cambio.find_all { |c| c.cantidad < 0 }
  end

  def sobrantes
    self.lista_de_cambio.find_all { |c| c.cantidad > 0 }
  end

  # Sí...
  def cantidad_faltante
    self.faltantes.map(&:cantidad).reduce(:+).abs
  end

  def cantidad_sobrante
    self.sobrantes.map(&:cantidad).reduce(:+)
  end

  private

    def crear_listas
      self.create_coleccion nombre: "Todas tus cartas"
      self.create_reserva nombre: "Playsets o buscadas"
      self
    end
end
