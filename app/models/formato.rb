# encoding: utf-8
class Formato < ActiveRecord::Base
  include FriendlyId

  TIPOS = [ 'Abierto', 'Cerrado' ]

  has_and_belongs_to_many :expansiones
  has_many :mazos_dedicados, inverse_of: :formato_objetivo
  has_and_belongs_to_many :cartas_prohibidas, class_name: 'Carta'
  has_many :torneos

  validates_presence_of :nombre
  validates_uniqueness_of :nombre
  validates_inclusion_of :tipo, in: TIPOS

  friendly_id :nombre, use: :slugged
  slugs_dependientes_en :torneos, dependencias: :nombre

  scope :ordenados, -> { order('tipo, nombre') }
  scope :abiertos, -> { where(tipo: 'Abierto') }

  def nombres_de_cartas_prohibidas=(nombres)
    if nombres.present?
      # Evita duplicación
      cartas_prohibidas.clear
      nombres.split(',').map(&:strip).each do |carta|
        self.cartas_prohibidas << Carta.find_by(nombre: carta) unless carta.blank?
      end
    end
  end

  def reglas
    @reglas ||= Reglas.new(self)
  end

  def reglas_para(mazo)
    Reglas.new(self, mazo)
  end

  private

    def should_generate_new_friendly_id?
      nombre_changed? || super
    end
end
