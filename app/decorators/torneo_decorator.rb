# encoding: utf-8
class TorneoDecorator < ApplicationDecorator
  decorates_association :inscripciones

  def identificador
    "#{object.formato_nombre} en #{object.tienda_nombre} el #{object.fecha}"
  end

  def preparar
    object.inscripciones.build unless object.inscripciones.any?
    self
  end

  def preinscriptos
    inscripciones.collect(&:nombre_o_usuario).join(', ').html_safe
  end

  def ronda_actual
    object.ultima_ronda + 1
  end

  def pairings
    pairings = object.sistema.pairing(ronda_actual).collect do |par|
      if par.first == par.last
        par.push object.bye
      end

      [ par.first.decorate.preparar(par.last),
        par.last.decorate.preparar(par.first) ]
    end
    pairings
  end
end
