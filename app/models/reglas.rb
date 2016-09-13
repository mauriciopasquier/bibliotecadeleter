class Reglas
  include ActiveModel::Validations

  class Null < Reglas
    def demonios_validos?; false; end

    def mazo_principal_valido?; false; end

    def mazo_suplente_valido?; false; end

    def copias_validas?; false; end

    def sendas_validas?; false; end

    def cartas_permitidas?; false; end

    def expansiones_validas?; false; end
  end

  validate  :demonios, :mazo_principal, :mazo_suplente, :copias, :sendas,
            :prohibidas, :expansiones

  attr_accessor :formato, :mazo

  def initialize(formato = nil, mazo = nil)
    @mazo = mazo
    @formato = formato
  end

  def demonios_validos?
    if mazo.changed?
      mazo.slots.collect(&:cantidad).sum
    else
      mazo.slots.sum(:cantidad)
    end == formato.demonios
  end

  def mazo_principal_valido?
    if mazo.principal.present?
      mazo.principal.cantidad == formato.principal
    else
      false # inválido sin mazo principal
    end
  end

  def mazo_suplente_valido?
    if formato.suplente.present? && mazo.suplente.present?
      mazo.suplente.cantidad == 0 ||
      mazo.suplente.cantidad == formato.suplente
    else
      # válido sin mazo suplente o si no se restringe la cantidad
      true
    end
  end

  def copias_validas?
    if formato.copias.present?
      if mazo.hay_cambios_en_las_listas?
        mazo.cartas_contadas.inject([]) do |sospechosas, version|
          sospechosas << Version.find(version.first) if version.last > formato.copias
          sospechosas
        end.reject(&:ilimitada?)
      else
        mazo.versiones.con_total('>', formato.copias).where(
          Version.arel_table[:supertipo].does_not_match('%ilimitad%').or(
          Version.arel_table[:supertipo].eq(nil))
        )
      end.empty?
    else
      # válido si no se restringe la cantidad de copias por carta
      true
    end
  end

  def sendas_validas?
    if formato.limitar_sendas?
      if mazo.hay_cambios_en_las_listas?
        mazo.slots_actuales.all? do |slot|
          sendas_permitidas.include? slot.version.senda
        end
      else
        mazo.versiones.where(
          Version.arel_table[:senda].not_in(
            [mazo.demonios.pluck(:senda).uniq + ['Neutral']]
          )
        ).empty?
      end
    else
      # válido si no hay límite de sendas
      true
    end
  end

  def cartas_permitidas?
    if formato.cartas_prohibidas.any?
      if mazo.hay_cambios_en_las_listas?
        cartas = mazo.slots_actuales.inject([]) do |cartas, slot|
          cartas << slot.version.carta and cartas
        end

        formato.cartas_prohibidas.count == (formato.cartas_prohibidas - cartas).count
      else
        formato.cartas_prohibidas.merge(mazo.cartas.to_a).empty?
      end
    else
      # válido si no hay cartas prohibidas
      true
    end
  end

  def expansiones_validas?
    # Buscar todas las cartas que no tengan al menos una versión en las
    # expansiones permitidas
    if formato.expansiones.any?
      if mazo.hay_cambios_en_las_listas?
        mazo.slots_actuales.all? do |slot|
          (slot.version.carta.expansiones & formato.expansiones).any?
        end && mazo.slots.all? do |slot|
          (slot.version.carta.expansiones & formato.expansiones).any?
        end
      else
        ids = formato.expansiones.pluck(:id)
        mazo.cartas.uniq.count ==
          mazo.cartas.en_expansiones(ids).uniq.count &&
        mazo.cartas_de_demonio.uniq.count ==
          mazo.cartas_de_demonio.en_expansiones(ids).uniq.count
      end
    else
      # válido si el formato no especifica expansiones
      true
    end
  end

  private

    def sendas_permitidas
      (mazo.slots.collect { |s| s.version.senda } + ['Neutral']).uniq
    end

    def demonios
      errors.add :mazo, :cantidad_de_demonios_mal unless demonios_validos?
    end

    def mazo_principal
      errors.add :mazo, :cantidad_en_el_mazo_mal unless mazo_principal_valido?
    end

    def mazo_suplente
      errors.add :mazo, :cantidad_en_el_mazo_suplente_mal unless mazo_suplente_valido?
    end

    def copias
      errors.add :mazo, :hay_copias_de_mas unless copias_validas?
    end

    def sendas
      errors.add :mazo, :cartas_en_las_sendas_incorrectas unless sendas_validas?
    end

    def prohibidas
      errors.add :mazo, :hay_cartas_prohibidas unless cartas_permitidas?
    end

    def expansiones
      errors.add :mazo, :cartas_en_expansiones_prohibidas unless expansiones_validas?
    end
end
