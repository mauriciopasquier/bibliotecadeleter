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
  has_one :coleccion, class_name: 'Lista', conditions: { coleccion: true },
                      dependent: :destroy

  friendly_id :nick, use: :slugged

  after_create :crear_coleccion

  private

    def crear_coleccion
      self.create_coleccion nombre: "Colección"
    end
end
