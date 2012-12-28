# encoding: utf-8
class Imagen < ActiveRecord::Base
  attr_accessible :archivo

  belongs_to :version
  has_one :carta, through: :version

  has_attached_file :archivo,
    { url: '/estaticos/cartas/:expansion/:numero-:nombre.:extension' }

  validates_attachment_presence :archivo

  def extension
    File.extname(archivo.path).delete('.')
  end
end
