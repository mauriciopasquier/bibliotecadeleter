# encoding: utf-8

namespace :cartas do

  desc "Adjunta las imágenes de las cartas de dir=directorio o /tmp/inferno/cartas/:expansion/:numero"
  task :adjuntar => :environment do

    dir = ENV['dir'] || "/tmp/inferno/cartas"
    Dir.foreach Rails.root.join(dir) do |expansion|
      next if expansion == '.' or expansion == '..' 

      begin
        Dir.glob("#{Rails.root.join(dir, expansion)}/*.jpg").sort.each do |i|

          puts i if ENV['log']
          # Asume imágenes guardadas de la forma `expansion/000. nombre.jpg`
          numero = File.basename(i).split('.').first
          Expansion.find(expansion).versiones.find_by_slug(numero).imagenes.create(
            archivo: File.open(i)
          )          

        end
      rescue => e
        puts "No se pudo adjuntar las imágenes de #{expansion}: #{e}"
      end
    end

  end

end
