# encoding: utf-8
class ApplicationDecorator < Draper::Base

  def hash_a_dl(*hash)
    clase = hash.extract_options!
    h.content_tag(:dl, class: clase[:dl]) do
      hash.first.collect do |dt, dd|
        h.content_tag(:dt, class: clase[:dt]) { dt.humanize } +
        Array.wrap(dd).collect do |item|
          h.content_tag(:dd, class: clase[:dd]) { item }
        end.join.html_safe
      end.join.html_safe
    end
  end

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
end
