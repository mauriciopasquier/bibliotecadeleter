# encoding: utf-8
module AutocompletarColumnas
  extend ActiveSupport::Concern

  module ClassMethods
    def autocompletar_columnas(*columnas)
      columnas.each do |columna|
        define_method("completar_#{columna}") do
          modelo = params[:controller].classify.constantize.select("distinct #{columna} as value")
          resultado = if (term = params[:term]).present?
            modelo.where modelo.arel_table[columna].matches("%#{term}%")
          else
            modelo.none
          end.inject({}) do |hash, elem|
            # Hash de id: value
            hash[elem.value] = elem.value
            hash
          end

          render json: resultado
        end
      end
    end
  end
end

# Autoinclusión de la extensión
ActionController::Base.send(:include, AutocompletarColumnas)
