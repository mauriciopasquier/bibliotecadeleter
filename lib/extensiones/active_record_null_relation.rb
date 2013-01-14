# encoding: utf-8
module ActiveRecordNullRelation
  extend ActiveSupport::Concern

  module ClassMethods

    # Devuelve una relación con 0 resultados, encadenable para no romper código.
    # TODO Actualizar a Rails 4 (este método ya está implementado ahí)
    def none
      where("1 = 0")
    end
  end
end

# Autoinclusión de la extensión
ActiveRecord::Base.send(:include, ActiveRecordNullRelation)
