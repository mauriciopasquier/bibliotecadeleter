# encoding: utf-8
# Define callbacks en los modelos para actualizar slugs relacionados con el
# modelo al que pertenecen.
#
#   slugs_dependientes_en_asociaciones :scope, :asociacion1, :asociacion2, :etc
#   slugs_dependientes_en              :scope, :asociacion1, :asociacion2, :etc
#
module SlugsDependientesEnAsociaciones
  extend ActiveSupport::Concern

  included do
    # FriendlyID regenera el slug cuando tratamos de guardarlo como nil
    def regenerar_slug
      update slug: nil
    end

    # Trata de regenera el slug de todos los registros asociados
    def regenerar_asociacion(asociacion)
      if as = self.send(asociacion)
        # Si es un modelo
        if as.respond_to? :regenerar_slug
          as.regenerar_slug
        # Si son varios
        else
          as.each(&:regenerar_slug)
        end
      end
    end
  end

  module ClassMethods
    # TODO agregar opciones para regenerar condicionalmente
    def slugs_dependientes_en_asociaciones(*asociaciones)
      # Definimos el método que regenera los slugs en cada asociación
      define_method "regenerar_slugs_asociados" do
        asociaciones.each do |asociacion|
          regenerar_asociacion asociacion
        end
      end

      # Definimos el callback para que regenere los slugs
      after_save :regenerar_slugs_asociados
    end

    # Comodidad
    alias_method :slugs_dependientes_en, :slugs_dependientes_en_asociaciones
  end
end

# Autoinclusión de la extensión
ActiveRecord::Base.send(:include, SlugsDependientesEnAsociaciones)
