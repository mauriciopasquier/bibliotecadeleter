class Diseno < ActiveRecord::Base
  include FriendlyId
  include PgSearch

  attr_readonly   :coste_convertido

  belongs_to :usuario

  before_save :convertir_coste

  validates_presence_of :nombre, :fundamento

  normalize_attributes  :texto, :tipo, :supertipo, :subtipo, :fue, :res, :senda,
                        :ambientacion, :coste, :fundamento

  friendly_id :nombre, use: :scoped, scope: :usuario

  multisearchable against: [ :coste, :nombre, :tipo, :supertipo, :subtipo,
    :senda, :texto, :ambientacion, :fue, :res, :usuario_nombre
    ], if: :persisted?

  delegate :nombre, to: :usuario, allow_nil: true, prefix: true

  scope :visibles, -> { where(visible: true) }
  scope :recientes, -> { order('updated_at desc').limit(10) }

  def siguiente
    usuario.disenos.where('created_at > ?', created_at).first ||
    usuario.disenos.first
  end

  def anterior
    usuario.disenos.where('created_at < ?', created_at).last ||
    usuario.disenos.last
  end

  private

    def convertir_coste
      self.coste_convertido = Version.coste_convertido(self.coste)
    end
end
