# encoding: utf-8
class Imagen < ActiveRecord::Base
  attr_accessible :archivo

  belongs_to :version
  has_one :carta, through: :version

  has_attached_file :archivo,
    { url:  "/estaticos/cartas/:style/:expansion/:carta-:numero.:extension",
      path: ":rails_root/public/cartas/:style/:expansion/:numero-:carta.:extension",
      styles: {
        thumb: "170x170" },
      convert_options: {
        # Remueve información de esquemas de colores y EXIF
        all: '-strip' },
      processors: [ :cartas ]
    }

  validates_attachment_presence :archivo
end
