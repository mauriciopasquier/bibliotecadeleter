# encoding: utf-8
class Imagen < ActiveRecord::Base
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
    { url:  "/cartas/:style/:expansion/:numero-:carta:cara.:extension",
      path: ":rails_root/public/cartas/:style/:expansion/:numero-:carta:cara.:extension",
      default_url: ":assets/imagen-no-disponible-:style.png",
      styles: {
        arte: "190x190",
        mini: "50%" },
      convert_options: {
        # Remueve información de esquemas de colores y EXIF
        all: '-strip' },
      processors: [ :cartas ]
    }

  def self.estilos
    [ :original, :mini, :arte ]
  end

  # Atributo virtual para el FormBuilder
  def arte=(nombres)
    if nombres.present?
      # Evita duplicación de artistas
      self.artistas.clear
      nombres.split(',').map(&:strip).each do |artista|
        self.artistas << Artista.find_or_create_by_nombre(artista) unless artista.blank?
      end
      self.artistas.map(&:touch)
    end
  end

  # Tal vez debería ir en un decorador
  def arte
    self.artistas.collect(&:nombre).join(', ')
  end
end
