# encoding: utf-8
require 'csv'

module SemillasHelper
  # Carga el archivo en formato csv +archivo+, del directorio +semillas+, que
  # tiene datos iniciales para la base de datos.
  def cargar_csv_de(archivo, configuracion = {})
    begin
      puts "Cargando CSV de #{archivo}.csv ..."
      CSV.foreach "db/semillas/#{archivo}.csv", configuracion do |fila|
        yield fila
      end
    rescue => e
      puts "No se pudo procesar #{archivo}: #{e}"
    end
  end

  # Extrae los atributos de las cartas del archivo csv
  def atributos_de_la_carta(csv)
    { nombre:       csv[0] }
  end

  # Extrae los atributos de las versiones del archivo csv
  def atributos_de_la_version(csv)
    { numero:       csv[1],
      rareza:       csv[2],
      tipo:         csv[3],
      supertipo:    csv[4],
      subtipo:      csv[5],
      senda:        csv[6],
      coste:        csv[7],
      fue:          csv[8],
      res:          csv[9],
      texto:        csv[11],
      ambientacion: csv[12] }
  end

  # Carga el archivo de semillas +archivo+, en formato yaml (con erb embebido) del
  # directorio +semillas+, que tiene datos iniciales para la base de datos
  def cargar_yml_de(archivo)
    YAML::load(
      ERB.new(
        IO.read(
          "db/semillas/#{archivo}.yml"
        )
      ).result
    ).with_indifferent_access
  end
end
