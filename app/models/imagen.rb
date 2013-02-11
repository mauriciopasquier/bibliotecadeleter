# encoding: utf-8
class Imagen < ActiveRecord::Base
  attr_accessible :archivo

  belongs_to :version, touch: true
  has_one :carta, through: :version
  has_one :expansion, through: :version
  has_and_belongs_to_many :artistas

  validates_presence_of :version

  delegate  :senda, :nombre, :coste, :rareza, :ambientacion, :fue, :res,
            :numero, :tipo, :subtipo, :supertipo, :canonica, :coste_convertido,
            :texto,
            to: :version

  # TODO revisar el asunto de las imágenes default y las no disponibles, para
  # evitar perder información (dibujante de la versión) cuando es conocida
  has_attached_file :archivo,
    { url:  ":assets/cartas/:style/:expansion/:numero-:carta:cara.:extension",
      path: ":rails_root/public/:assets/cartas/:style/:expansion/:numero-:carta:cara.:extension",
      styles: {
        arte: "190x190",
        mini: "50%" },
      convert_options: {
        # Remueve información de esquemas de colores y EXIF
        all: '-strip' },
      processors: [ :cartas ]
    }

  validates_attachment_presence :archivo

  def self.estilos
    [ :original, :mini, :arte ]
  end
end
