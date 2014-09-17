class TiendaDecorator < ApplicationDecorator
  def lista_de_paginas
    object.links.map do |l|
      h.link_to l.nombre, l.url
    end.join(', ').html_safe
  end

  def ubicacion
    [ direccion, region].join ', en '
  end

  def region
    object.region || 'el Inferno'
  end
end
