class Sobre
  attr_accessor :raras, :infrecuentes, :comunes, :proporcion_epica

  def initialize(opciones = {})
    opciones.reverse_merge! raras: 1, infrecuentes: 3, comunes: 6, proporcion_epica: 0.2
    @raras = opciones[:raras]
    @infrecuentes = opciones[:infrecuentes]
    @comunes = opciones[:comunes]
    @proporcion_epica = opciones[:proporcion_epica]
  end

  def self.abrir(cartas)
    new.abrir(cartas)
  end

  # TODO tener en cuenta las fichas
  def abrir(cartas)
    cartas.where(rareza: rara_o_epica).scoped.sample(raras) +
    cartas.where(rareza: 'Infrecuente').scoped.sample(infrecuentes) +
    cartas.where(rareza: 'Común').scoped.sample(comunes)
  end

  def rara_o_epica
    rand > proporcion_epica ? 'Rara' : 'Épica'
  end
end
