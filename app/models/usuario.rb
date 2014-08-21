# encoding: utf-8
class Usuario < ActiveRecord::Base
  include FriendlyId
  include Gravtastic

  has_merit

  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :links, as: :linkeable, dependent: :destroy
  has_many :listas, dependent: :destroy
  has_many :mazos, dependent: :destroy
  has_many :disenos, -> { order(:created_at) }, dependent: :destroy
  has_many :torneos_organizados, class_name: 'Torneo',
    inverse_of: :organizador, foreign_key: :organizador_id
  has_many :inscripciones, foreign_key: :codigo, primary_key: :codigo
  has_many :torneos_jugados, through: :inscripciones
  has_one :coleccion, dependent: :destroy
  has_one :reserva, dependent: :destroy

  friendly_id :nick, use: :slugged

  has_gravatar
  has_attached_file :avatar, {
    url:  "/avatar/:slug/:style.:extension",
    path: ":rails_root/public/avatar/:slug/:style.:extension",
    default_url: "/avatar-no-disponible-:style.jpg",
    styles: {
      chico:    '80x80',
      arte:     '190x190',
      grande:   '256x256'
    },
    convert_options: {
      all: '-strip'
    },
    default_style: :arte
  }

  validates_attachment :avatar,
    content_type: { content_type: %w{image/jpeg image/gif image/png} }

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

  def medallas
    persisted? ? badges : []
  end

  # Forem necesita estos
  def to_s
    nick
  end

  # Este está definido en el initializer
  def avatar_decorado
    decorate.algun_avatar
  end

  # TODO unificar API con Imagen
  def estilos
    avatar.styles.inject({}) do |hash, estilo|
      hash[estilo.first] = estilo.last.geometry and hash
    end
  end

  private

    def crear_listas
      self.create_coleccion nombre: "Todas tus cartas", visible: false
      self.create_reserva nombre: "Playsets o buscadas", visible: false
      self
    end

    def asociarse
      # Devise genera un nuevo token de confirmación si actualizamos el
      # usuario. Cuando se agrega esta medalla el usuario todavía no ha tenido
      # tiempo de confirmar, entonces la salteamos
      skip_reconfirmation!
      self.add_badge SOCIO.id
    end

    def should_generate_new_friendly_id?
      nick_changed? || super
    end
end
