# encoding: utf-8
class RondaDecorator < ApplicationDecorator
  def resultado
    case object.puntos
      when 3
        h.content_tag(:span, class: 'text-success') do
          h.content_tag(:b, 'Ganó')
        end
      when 1
        h.content_tag(:span, class: 'text-warning') do
          h.content_tag(:b, 'Empató')
        end
      else
        h.content_tag(:span, class: 'text-error') do
          h.content_tag(:b, 'Perdió')
        end
    end
  end

  def oponente
    object.oponente.bye? ? 'por Bye' : "contra #{object.oponente.participante}"
  end

  def partidas
    "#{object.partidas_ganadas} a #{partidas_oponente}"
  end

  def partidas_oponente
    oponente = object.oponente.rondas.where(numero: object.numero).first
    oponente.present? ? oponente.partidas_ganadas : 0
  end
end
