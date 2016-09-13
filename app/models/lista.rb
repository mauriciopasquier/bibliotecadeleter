# encoding: utf-8
class Lista < ActiveRecord::Base
  include FriendlyId
  include PgSearch

  belongs_to :usuario
  has_many :slots, as: :inventario, dependent: :destroy
  has_many :versiones, through: :slots, extend: VersionesContadas
  has_many :cartas, through: :versiones

  friendly_id :nombre, use: :scoped, scope: :usuario

  validates_uniqueness_of :nombre, scope: :usuario_id
  validates_presence_of :nombre

  accepts_nested_attributes_for :slots, allow_destroy: true,
    reject_if: :all_blank

  # Para copiar listas (y suplentes, principales, etc) de un usuario a otro
  amoeba do
    nullify [:usuario_id, :slug]
    clone [:slots]
    propagate
  end

  %w{Lista Coleccion Reserva Principal Suplente}.each do |tipo|
    define_method "#{tipo.downcase}?" do
      self.type == tipo
    end
  end

  scope :visibles, -> { where(visible: true) }
  scope :recientes, -> { order('updated_at desc').limit(10) }
  scope :normales, -> { where(type: 'Lista') }

  delegate :nombre, to: :usuario, allow_nil: true, prefix: true

  multisearchable against: [:nombre, :usuario_nombre, :nombres_de_las_cartas,
    :notas],
    if: :lista?

  # Agrupar y sumar los slots que referencian a una misma versión. Actualmente
  # sólo se garantiza la unicidad de versión si todos los slots se guardan a la
  # vez
  def slots_attributes=(slots_params)
    agrupados = slots_params.group_by do |_, v|
      v[:version_id]
    end.collect do |version_id, slots|
      # Los marcados para destrucción no se suman pero deben 'guardarse'
      destruir, sumar = slots.partition do |_, v|
        ActiveRecord::ConnectionAdapters::Column.value_to_boolean v[:_destroy]
      end

      if sumar.any?
        # Seleccionamos uno donde acumular los demás
        elegido_id, elegido = sumar.shift
        elegido[:cantidad] = elegido[:cantidad].to_i

        sumados = sumar.collect do |_, slot|
          elegido[:cantidad] += slot[:cantidad].to_i
          # Marcamos los ya sumados para destrucción
          slot[:_destroy] = true and slot
        end + [elegido]

        destruir.collect(&:last) + sumados
      else
        destruir.collect(&:last)
      end
    end

    assign_nested_attributes_for_collection_association :slots, agrupados.flatten
  end

  # Devuelve todos los slots tanto en esta lista como en `otra`
  # TODO ver cómo scopearlo
  def comparar_con(otra)
    Slot.where(inventario_id: [self, otra]).menos(otra)
  end

  # Cantidad de cartas en la lista
  def cantidad
    if slots.any?(&:changed?)
      slots.collect(&:cantidad).sum
    else
      slots.sum(:cantidad)
    end
  end

  def nombres_de_las_cartas
    cartas.collect(&:nombre).join(' ')
  end

  protected

    def should_generate_new_friendly_id?
      nombre_changed? || super
    end
end
