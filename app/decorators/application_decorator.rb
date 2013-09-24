# encoding: utf-8
class ApplicationDecorator < Draper::Decorator
  delegate_all

  # Para evitar que `cycle` devuelva cadenas vacías cuando debería devolver
  # nil, lo que genera tags con `class=""` en vez de nada.
  def nil_cycle(first_value, *values)
    r = h.cycle(first_value, *values)
    case r
      when ""
        nil
      else
        r
    end
  end

  # Interfaz común para preparar nuevos objetos con las asociaciones necesarias
  # AlgoDecorator.preparar devuelve un nuevo Algo decorado y preparado
  def self.preparar
    self.new(object_class.new).preparar
  end

  # Los decoradores deberían implementar este método y devolver `self`
  def preparar
    raise NoMethodError
  end
end
