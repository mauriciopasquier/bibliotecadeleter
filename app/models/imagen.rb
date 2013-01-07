# encoding: utf-8
class Imagen < ActiveRecord::Base
  attr_accessible :archivo

  belongs_to :version
  has_one :carta, through: :version

  has_attached_file :archivo,
    { url:  ":assets/cartas/:style/:expansion/:numero-:carta:cara.:extension",
      path: ":rails_root/public/:assets/cartas/:style/:expansion/:numero-:carta:cara.:extension",
      styles: {
        thumb: "170x170" },
      convert_options: {
        # Remueve información de esquemas de colores y EXIF
        all: '-strip' },
      processors: [ :cartas ]
    }

  validates_attachment_presence :archivo
end
