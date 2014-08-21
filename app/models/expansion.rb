# encoding: utf-8
class Expansion < ActiveRecord::Base
  include FriendlyId
  include PgSearch

  has_many :versiones, -> { order('slug ASC') }, dependent: :destroy,
    inverse_of: :expansion
  has_many :cartas, through: :versiones
  has_many :imagenes, -> { order('versiones.slug ASC') }, through: :versiones
  has_and_belongs_to_many :formatos

  friendly_id :nombre, use: :slugged
  slugs_dependientes_en :versiones, dependencias: :nombre

  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  scope :grandes, -> { where('total >= ?', 100) }
  scope :ordenadas, -> { order('lanzamiento, created_at') }

  has_attached_file :logo, {
    url:  "/expansiones/:slug.:extension",
    path: ":rails_root/public/expansiones/:slug.:extension",
    convert_options: { all: '-strip' }
  }

  validates_attachment :logo,
    content_type: { content_type: %w{image/jpeg image/gif image/png} }

  multisearchable against: [ :nombre, :saga, :notas ]

  normalize_attribute :codigo, with: :upcase

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

  private

    def should_generate_new_friendly_id?
      nombre_changed? || super
    end
end
