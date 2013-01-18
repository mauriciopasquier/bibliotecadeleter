# encoding: utf-8
class ArtistaDecorator < ApplicationDecorator
  decorates :artista
  decorates_association :versiones
  decorates_association :ilustraciones

  def galeria(pagina = 1, cantidad = 10)
    ilustraciones.paginar(pagina, cantidad).decorate
  end
end
