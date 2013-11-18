# encoding: utf-8
class Expansion < ActiveRecord::Base
  include FriendlyId
  include PgSearch

  has_many :versiones, order: 'slug ASC', dependent: :destroy
  has_many :cartas, through: :versiones
  has_many :imagenes, through: :versiones, order: 'versiones.slug ASC'
  has_and_belongs_to_many :formatos

  friendly_id :nombre, use: :slugged

  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  scope :grandes, where('total >= ?', 100)
  scope :ordenadas, order('lanzamiento, created_at')

  has_attached_file :logo, {
    url:  "/expansiones/:slug.:extension",
    path: ":rails_root/public/expansiones/:slug.:extension",
    convert_options: { all: '-strip' }
  }

  multisearchable against: [ :nombre, :saga, :notas ]

  # Determina de qué expansión son las promocionales
  def base
    if slug =~ /promocionales/
      Expansion.find slug.gsub('promocionales-', '')
    else
      self
    end
  end

  def abrir_sobre
    Sobre.abrir(versiones)
  end
end
