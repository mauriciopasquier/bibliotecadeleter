class Reglas
  include ActiveModel::Validations

  attr_accessor :formato, :mazo

  def initialize(formato = nil, mazo = nil)
    @mazo = mazo
    @formato = formato
  end

  validate  :demonios, :mazo_principal, :mazo_suplente, :copias, :sendas,
            :prohibidas, :expansiones

  # mazo.errors.add?
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

  def demonios_validos?
    mazo.slots.sum(:cantidad) == formato.demonios
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
      mazo.versiones.con_total('>', formato.copias).where(
        Version.arel_table[:supertipo].does_not_match('%ilimitad%').or(
        Version.arel_table[:supertipo].eq(nil))
      ).empty?
    else
      # válido si no se restringe la cantidad de copias por carta
      true
    end
  end

  def sendas_validas?
    if formato.limitar_sendas?
      mazo.versiones.where(
        Version.arel_table[:senda].not_in(
          [ mazo.demonios.pluck(:senda).uniq + ['Neutral'] ]
        )
      ).empty?
    else
      # válido si no hay límite de sendas
      true
    end
  end

  def cartas_permitidas?
    if formato.cartas_prohibidas.any?
      formato.cartas_prohibidas.merge(mazo.cartas).empty?
    else
      # válido si no hay cartas prohibidas
      true
    end
  end

  def expansiones_validas?
    if formato.expansiones.any?
      mazo.versiones.where(Version.arel_table['expansion_id'].not_in(
        formato.expansiones.pluck(:id)
      )).empty?
    else
      # válido si el formato no especifica expansiones
      true
    end
  end
end
