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

  def markdown_seguro(mdwn)
    if mdwn.blank?
      ''
    else
      # TODO diferentes scrubs para diferentes medallas
      Loofah.fragment(
        Kramdown::Document.new(mdwn).to_html
      ).scrub!(:whitewash).to_s.html_safe
    end
  end

  # Envuelve las oraciones (delimitadas por '\r\n') en <p> y los ( ) en <i>
  def estructurar(texto)
    texto.split("\r\n").collect do |oracion|
      h.content_tag :p, oracion.gsub('(', '<i>(').gsub(')', ')</i>').html_safe
    end.join.html_safe
  end
end
