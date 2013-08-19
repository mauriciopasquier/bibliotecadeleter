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
  has_one :total, dependent: :destroy

  friendly_id :nick, use: :slugged

  after_create :crear_listas

  private

    def crear_listas
      self.create_coleccion nombre: "Tu colección"
      self.create_total nombre: "Todas tus cartas"
      self
    end
end
