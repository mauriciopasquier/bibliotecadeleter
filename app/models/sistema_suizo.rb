class SistemaSuizo
  include ActiveModel::Validations

  validate :cantidad_de_inscriptos

  attr_accessor :inscriptos, :corte

  TIEMPO = {  ronda: 50.minutes,
              registro: 20.minutes,
              construccion: 30.minutes }

  PUNTOS = {  empate: 1,
              victoria: 3,
              derrota: 0 }

  def initialize(inscriptos)
    @inscriptos = inscriptos
    @corte = inscriptos.size > 128
  end

  def pairing(ronda)
    if ronda <= rondas
      ronda == 1 ? aleatorio : por_ranking
    else
      []
    end
  end

  def rondas
    case inscriptos.size
      when 0..7     then 0
      when 8        then 3
      when 9..16    then 4
      when 17..32   then 5
      when 33..64   then 6
      when 65..128  then 7
      else
        7
    end
  end

  def cantidad_de_inscriptos_valida?
    inscriptos.size >= 8
  end

  private

    def aleatorio
      mezclados = inscriptos.shuffle
      pares = []
      while mezclados.any?
        pares << mezclados.pop(2)
      end
      pares
    end

    def por_ranking
      # 1. Agrupar por puntaje
      grupos_rankeados = inscriptos.group_by {|i| i.puntos }.sort.reverse

      pares = []
      while grupos_rankeados.any?
        # 2. Para cada grupo de jugadores con el mismo puntaje, pairear al azar
        rankeados = grupos_rankeados.shift.last.shuffle

        # 2.1. Agregando el sobrante del grupo anterior si es que hubo
        rankeados.unshift(pares.pop.first) if pares.last.try(:size).try(:==, 1)

        while rankeados.any?
          uno = rankeados.shift

          # 2.2. Tratando de evitar la repetición de oponente
          oponente_index = rankeados.index { |otro| !uno.ha_jugado_con?(otro) }

          oponente = if oponente_index.present?
            rankeados.delete_at oponente_index
          else
            nil
          end

          # 3. Si sólo queda un oponente contra el que ya se jugó, probar de
          # nuevo con el pairing repitiendo 2
          if oponente.nil? && rankeados.size == 1
            rankeados = (rankeados + pares.pop).shuffle.unshift(uno)
          else
            pares << [uno] + Array.wrap(oponente)
          end
        end
      end
      pares
    end

    def cantidad_de_inscriptos
      unless cantidad_de_inscriptos_valida?
        errors.add :inscriptos, :cantidad_insuficiente
      end
    end
end
