# encoding: utf-8
class Formato < ActiveRecord::Base
  include FriendlyId

  has_and_belongs_to_many :expansiones
  has_many :mazos_dedicados, inverse_of: :formato_objetivo
  has_and_belongs_to_many :cartas_prohibidas, class_name: 'Carta'

  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  friendly_id :nombre, use: :slugged

  def nombres_de_cartas_prohibidas=(nombres)
    if nombres.present?
      # Evita duplicación
      cartas_prohibidas.clear
      nombres.split(',').map(&:strip).each do |carta|
        self.cartas_prohibidas << Carta.find_by_nombre(carta) unless carta.blank?
      end
    end
  end
end
