# encoding: utf-8
require 'semillas_helper'
# En este archivo va la carga inicial de datos. La mayoría de estos datos
# residen en db/semillas/, en diferentes archivos y formatos. Acá se realiza la
# carga.

extend SemillasHelper

# Carga las ediciones
cargar_yml_de('expansiones').each do |expansion|
  nombre, datos = expansion
  puts "Creando expansion #{nombre} ..."
  Expansion.find_or_create_by_nombre(nombre) do |e|
    e.total = datos[:total]
    e.lanzamiento = datos[:lanzamiento]
    e.presentacion = datos[:presentacion]
    e.saga = datos[:saga]
    e.notas = datos[:notas]
  end
end

expansiones = if ENV['expansiones']
  ENV['expansiones'].split(',').collect { |e| Expansion.find e }
else
  Expansion.all
end

# Carga cada carta, versiones y artistas de las expansiones indicadas
expansiones.each do |expansion|

  unless ENV['dir']
    raise ArgumentError, 'Necesitamos un directorio con las imágenes (dir=directorio)'
  else
    dir = ENV['dir']
  end

  imagenes_expansion = Dir.glob("#{File.join(dir, expansion.slug)}/*.jpg").sort
  puts "Cargando imágenes de #{File.join(dir, expansion.slug)}"

  cargar_csv_de(expansion.nombre.parameterize, headers: true, col_sep: ',') do |carta|
    c = Carta.find_or_create_by_nombre(atributos_de_la_carta(carta))
    v = c.versiones.create(atributos_de_la_version(carta, expansion))

    imagenes_carta = imagenes_expansion.select do |i|
      i =~ /#{v.numero_justificado}/
    end

    # Divide en 2 caras los demonios, las demás cartas en 1
    carta[10].split('/').each do |cara|
      # Creo la imagen, si es que hay
      if imagenes_carta.any?
        imagen = v.imagenes.create(archivo: File.open(imagenes_carta.shift))
      end
      # Separa a los artistas cuando hay colaboraciones
      cara.split('-').each do |artista|
        a = Artista.find_or_create_by_nombre(artista.strip)
        if imagen
          a.ilustraciones << imagen
        end
      end
    end

    c.save!
  end
end
