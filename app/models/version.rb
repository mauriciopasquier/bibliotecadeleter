# encoding: utf-8
class Version < ActiveRecord::Base
  include FriendlyId
  include PgSearch

  attr_readonly   :coste_convertido

  belongs_to :carta, inverse_of: :versiones, touch: true
  belongs_to :expansion, touch: true
  has_many :imagenes, -> { order('created_at ASC') },
            inverse_of: :version, dependent: :destroy
  has_many :artistas, through: :imagenes
  has_many :links, as: :linkeable, dependent: :destroy
  has_many :slots

  friendly_id :expansion_y_numero, use: :slugged

  normalize_attributes  :texto, :tipo, :supertipo, :subtipo, :fue, :res, :senda,
                        :ambientacion, :rareza, :coste

  accepts_nested_attributes_for :imagenes, reject_if: :all_blank

  before_save :ver_si_es_canonica, :convertir_coste
  before_save :actualizar_path_de_imagenes, if: :numero_changed?

  validates_uniqueness_of :numero, scope: :expansion_id, message: :no_es_unico_en_la_expansion
  validates_presence_of :carta, inverse_of: :versiones

  scope :costeadas, -> { where.not(coste_convertido: nil) }
  scope :demonios, -> { where(supertipo: 'Demonio') }
  scope :caos,    -> { where(senda: 'Caos') }
  scope :locura,  -> { where(senda: 'Locura') }
  scope :muerte,  -> { where(senda: 'Muerte') }
  scope :poder,   -> { where(senda: 'Poder') }
  scope :neutral, -> { where(senda: 'Neutral') }

  delegate :nombre, to: :carta, allow_nil: true
  delegate :nombre_y_expansiones, to: :carta, allow_nil: true
  delegate :nombre, to: :expansion, allow_nil: true, prefix: true

  multisearchable against: [ :coste, :nombre, :tipo, :supertipo, :subtipo,
    :senda, :texto, :ambientacion, :fue, :res, :expansion_nombre, :rareza,
    :arte ], if: :persisted?

  # Para copiar una versión sin expansión ni imágenes, por ejemplo para las
  # reediciones
  amoeba do
    exclude_field :imagenes
    nullify [ :expansion_id, :slug, :numero ]
  end

  def self.no_fichas
    where arel_table[:supertipo].not_eq('Ficha').or(arel_table[:supertipo].eq(nil))
  end

  def self.normales
    where arel_table[:supertipo].not_eq('Demonio').or(arel_table[:supertipo].eq(nil))
  end

  # Devuelve el slot en el que esta versión está en la `lista`
  def slot_en(lista)
    lista.slots.where(version_id: id).first
  end

  def self.coste_convertido(coste = nil)
    coste.present? ? coste.to_s.gsub(/\D/, '').to_i : nil
  end

  def numero_justificado
    numero.to_s.rjust(3, '0')
  end

  # Para ordenar los resultados con +sort_by+
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

  def nombre_y_expansion
    (self.nombre || '') + (self.expansion.nil? ? '' : " (#{self.expansion.nombre})")
  end

  def demonio?
    self.supertipo.try :include?, 'Demonio'
  end

  def ilimitada?
    self.supertipo.try :include?, 'Ilimitad'
  end

  def arte
    self.artistas.collect(&:nombre).join(', ')
  end

  def siguiente
    expansion.versiones.where('numero > ?', numero).first ||
    expansion.versiones.first
  end

  def anterior
    expansion.versiones.where('numero < ?', numero).last ||
    expansion.versiones.last
  end

  private

    # Usá `slug` para llamar a esto
    def expansion_y_numero
      "#{numero_justificado}-#{expansion.try(:slug) || 'huerfanas'}"
    end

    # La primer versión de cada carta es la canónica
    def ver_si_es_canonica
      unless Version.where(carta_id: carta_id, canonica: true).any?
        self.canonica = true
      end
      true # Para que siga guardandola
    end

    def convertir_coste
      self.coste_convertido = Version.coste_convertido(self.coste)
    end

    def actualizar_path_de_imagenes
      imagenes.each do |i|
        Imagen.estilos.each do |estilo|

          if nuevo = i.archivo.path(estilo)
            viejo = nuevo.gsub numero_justificado, numero_was.to_s.rjust(3, '0')
            File.rename(viejo, nuevo) if File.exists?(viejo)
          end

        end
      end
    end
end
