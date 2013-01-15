# encoding: utf-8
class Version < ActiveRecord::Base
  include FriendlyId

  attr_accessible :ambientacion, :coste, :fue, :numero, :rareza, :res, :senda,
                  :subtipo, :supertipo, :texto, :tipo, :canonica,
                  :imagenes_attributes, :carta, :expansion, :expansion_id

  belongs_to :carta, inverse_of: :versiones
  has_and_belongs_to_many :artistas
  belongs_to :expansion
  has_many :imagenes

  friendly_id :expansion_y_numero, use: :slugged

  accepts_nested_attributes_for :imagenes

  before_save :ver_si_es_canonica

  validates_presence_of :carta

  def numero_justificado
    numero.to_s.rjust(3, '0')
  end

  private

    def expansion_y_numero
      "#{expansion.try(:slug) || 'huerfanas'}-#{numero_justificado}"
    end

    def ver_si_es_canonica
      unless carta.versiones.where(canonica: true).any?
        self.canonica = true
      end
      true # Para que siga guardandola
    end

end
