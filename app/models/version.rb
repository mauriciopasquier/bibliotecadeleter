# encoding: utf-8
class Version < ActiveRecord::Base
  include FriendlyId

  attr_accessible :ambientacion, :coste, :fue, :numero, :rareza, :res, :senda,
                  :subtipo, :supertipo, :texto, :tipo, :canonica, :carta,
                  :imagenes_attributes, :expansion, :expansion_id, :imagen
  attr_readonly   :coste_convertido


  belongs_to :carta, inverse_of: :versiones, touch: true
  delegate :nombre, to: :carta, allow_nil: true
  belongs_to :expansion, touch: true
  has_many :imagenes, order: 'created_at ASC',
            inverse_of: :version, dependent: :destroy
  has_many :artistas, through: :imagenes
  has_many :links, as: :linkeable, dependent: :destroy

  friendly_id :expansion_y_numero, use: :slugged

  accepts_nested_attributes_for :imagenes, reject_if: :all_blank

  before_save :ver_si_es_canonica, :convertir_coste

  validates_uniqueness_of :numero, scope: :expansion_id, message: :no_es_unico_en_la_expansion
  validates_presence_of :carta, inverse_of: :versiones

  scope :costeadas, where(Version.arel_table['coste_convertido'].not_eq(nil))

  def self.coste_convertido(coste = nil)
    coste.present? ? coste.to_s.gsub(/\D/, '').to_i : nil
  end

  def numero_justificado
    numero.to_s.rjust(3, '0')
  end

  # Permite ordenar los resultados con +sort_by+
  def self.prioridad_de_senda(senda)
    case senda.downcase.to_sym
      when :caos    then 1
      when :locura  then 2
      when :muerte  then 3
      when :poder   then 4
      when :neutral then 5
      else
        nil
    end
  end

  def prioridad
    Version.prioridad_de_senda(self.senda)
  end

  # Permite copiar una versión sin expansión ni imágenes, para las reediciones
  amoeba do
    exclude_field :imagenes
    nullify [ :expansion_id, :slug, :numero ]
  end

  private

    # Usá `slug` para llamar a esto
    def expansion_y_numero
      "#{numero_justificado}-#{expansion.try(:slug) || 'huerfanas'}"
    end

    def ver_si_es_canonica
      unless carta.versiones.where(canonica: true).any?
        self.canonica = true
      end
      true # Para que siga guardandola
    end

    def convertir_coste
      self.coste_convertido = Version.coste_convertido(self.coste)
    end
end
