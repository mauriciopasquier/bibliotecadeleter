class Bye
  attr_reader :torneo, :partidas_ganadas, :puntos, :codigo, :participante

  def initialize(torneo, partidas = 0, puntos = 0, codigo = 'Bye', nombre = 'Bye')
    @torneo = torneo
    @partidas_ganadas = partidas
    @puntos = puntos
    @codigo = codigo
    @participante = nombre
  end

  delegate :id, to: :torneo, prefix: true

  def decorate
    InscripcionDecorator.new(self)
  end

  def bye?
    true
  end

  def id
    nil
  end

  def rondas
    Ronda.none
  end

  def usuario
    Usuario.none
  end

  def persisted?
    true
  end

  def partidas_ganadas_en(numero)
    0
  end
end
