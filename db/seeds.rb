# encoding: utf-8
# En este archivo va la carga inicial de datos. La mayoría de estos datos
# residen en db/semillas/, en diferentes archivos y formatos. Acá se realiza la
# carga.

require 'semillas_helper'
extend SemillasHelper

# Carga las ediciones
cargar_yml_de('expansiones').each do |expansion|
  nombre, datos = expansion
  puts "Cargando expansion #{nombre} ..."
  Expansion.find_or_create_by_nombre(nombre) do |e|
    e.total = datos[:total]
    e.lanzamiento = datos[:lanzamiento]
    e.presentacion = datos[:presentacion]
    e.notas = datos[:notas]
  end
end

# Carga cada carta, versiones y artistas
Expansion.all.each do |expansion|
  cargar_csv_de(expansion.nombre.parameterize, headers: true, col_sep: ',') do |carta|
    c = Carta.create(atributos_de_la_carta(carta))
    v = c.versiones.create(atributos_de_la_version(carta))

    # Divide en 2 caras los demonios, las demás cartas en 1
    carta[10].split('/').each do |cara|
      # Separa a los artistas cuando hay colaboraciones
      cara.split('-').each do |artista|
        v.artistas << Artista.find_or_create_by_nombre(artista.strip)
      end
    end

    v.expansion = expansion

    c.save!
  end
end
