# encoding: utf-8
# Para definir en los controladores métodos que devuelvan los valores
# existentes en las columnas especificadas
#
#   autocompletar_valores :expansion, :saga
#   autocompletar_valores :version, :tipo, :supertipo, :subtipo
#
module AutocompletarColumnas
  extend ActiveSupport::Concern

  included do
    # Busca y restringe
    def filtro(modelo, columna, restriccion = { })
      if term.present?
        modelo.where(restriccion).where(
          modelo.arel_table[columna].matches("%#{term}%")
        ).limit(10)
      else
        modelo.none
      end
    end

    # Arma el json y lo devuelve
    def autocompletar(resultados, llave, valor, label = nil, otros = [])
      h = resultados.inject({}) do |hash, elem|

        hash[elem.send(llave)] = {

          label: elem.send(label || valor),
          value: elem.send(valor),
          id: elem.send(llave)

        }.merge(otros.inject({}) do |hash, otro|
          hash[otro] = elem.send(otro)
          hash
        end)

        hash
      end
      render json: h
    end

    # Oculta los params
    def term
      params[:term]
    end
  end

  module ClassMethods
    def autocompletar_valores(modelo, *columnas)
      opciones = columnas.extract_options!

      columnas.each do |columna|

        incluir = Array.wrap(opciones[:incluir]) - [columna]

        define_method("valores_#{modelo}_#{columna}") do
          valores = modelo.to_s.classify.constantize.select(
            [
              "distinct #{columna} as value",
              *incluir
            ].join(', ')
          )

          autocompletar filtro(valores, columna), :value, :value, :value, incluir
        end
      end
    end
  end
end

# Autoinclusión de la extensión
ActionController::Base.send(:include, AutocompletarColumnas)
