# encoding: utf-8
class Usuario < ActiveRecord::Base
  include FriendlyId

  has_merit

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :links, as: :linkeable, dependent: :destroy
  has_many :listas, dependent: :destroy
  has_many :mazos, dependent: :destroy
  has_one :coleccion, dependent: :destroy
  has_one :reserva, dependent: :destroy

  friendly_id :nick, use: :slugged

  after_create :crear_listas, :asociarse

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

  def medallas=(lista = [])
    Array.wrap(lista).each { |m| self.add_badge m.id }
  end
  alias_method :medallas, :badges

  private

    def crear_listas
      self.create_coleccion nombre: "Todas tus cartas"
      self.create_reserva nombre: "Playsets o buscadas"
      self
    end

    def asociarse
      self.add_badge SOCIO.id
    end
end
