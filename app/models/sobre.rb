class Sobre
  attr_accessor :raras, :infrecuentes, :comunes, :proporcion_epica

  # proporcion_epica indica cada cuántos sobres una carta épica reemplaza a una
  # rara (en general es en 1 de 5 sobres)
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
    cartas.where(rareza: rara_o_epica).no_fichas.sample(raras) +
    cartas.where(rareza: 'Infrecuente').no_fichas.sample(infrecuentes) +
    cartas.where(rareza: 'Común').no_fichas.sample(comunes)
  end

  # Para poder forzar una rareza:
  # - proporción 0.0 => Rara
  # - proporción 1.0 => Épica
  # Uso <= porque rand puede dar 0 pero no 1
  def rara_o_epica
    proporcion_epica <= rand ? 'Rara' : 'Épica'
  end
end
