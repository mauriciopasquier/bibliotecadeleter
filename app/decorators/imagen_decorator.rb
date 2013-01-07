# encoding: utf-8
class ImagenDecorator < ApplicationDecorator
  decorates :imagen

  def tag(estilo = :original)
    h.image_tag source.archivo.url(estilo), alt: source.carta.nombre
  end

end
