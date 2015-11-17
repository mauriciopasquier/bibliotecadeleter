# encoding: utf-8
class Imagen < ActiveRecord::Base
  store_accessor :metadatos, :geometria_original, :geometria_mini, :geometria_arte

  belongs_to :version, touch: true, inverse_of: :imagenes
  has_one :carta, through: :version
  has_one :expansion, through: :version
  has_and_belongs_to_many :artistas

  validates_presence_of :version

  delegate  :senda, :nombre, :coste, :rareza, :ambientacion, :fue, :res,
            :numero, :tipo, :subtipo, :supertipo, :canonica, :coste_convertido,
            :texto,
            to: :version

  has_attached_file :archivo,
    url:  '/system/cartas/:style/:expansion/:numero-:carta:cara.:extension',
    path: ':rails_root/public/system/cartas/:style/:expansion/:numero-:carta:cara.:extension',
    default_url: '/imagen-no-disponible-:style.png',
    styles: {
      arte: '190x190',
      mini: '50%' },
    convert_options: {
      # Remueve información de esquemas de colores y EXIF
      all: '-strip' },
    processors: [ :cartas ]

  validates :archivo,
    attachment_content_type: { content_type: %w{image/jpeg image/png} }

  before_save :guardar_metadatos_de_archivos

  def self.estilos
    [:original, :mini, :arte]
  end

  # Atributo virtual para el FormBuilder
  def arte=(nombres)
    if nombres.present?
      unless nombres.split(', ').sort.join(', ') == arte
        # Evita duplicación de artistas
        self.artistas.clear
        nombres.split(',').map(&:strip).each do |artista|
          self.artistas << Artista.find_or_create_by(nombre: artista) unless artista.blank?
        end
        self.artistas.map(&:touch)
      end
    end
  end

  def arte
    (persisted? ? artistas.reorder(:nombre) : artistas).collect(&:nombre).join(', ')
  end

  # TODO testear
  def actualizar_path(viejo_nombre, nuevo_nombre)
    Imagen.estilos.each do |estilo|

      if nuevo = archivo.path(estilo)
        viejo = nuevo.gsub nuevo_nombre, viejo_nombre
        File.rename(viejo, nuevo) if File.exists?(viejo)
      end
    end
  end

  # Es una contracara si no es cara
  def contracara?
    !cara
  end

  def guardar_metadatos_de_archivos
    if archivo_updated_at_changed?
      guardar_metadatos_de_archivos!
    end
  end

  def guardar_metadatos_de_archivos!
    Imagen.estilos.each do |estilo|
      if File.exists?(archivo.path(estilo))
        send "geometria_#{estilo}=", Paperclip::Geometry.from_file(archivo.path(estilo)).to_s
      end
    end
  end
end
