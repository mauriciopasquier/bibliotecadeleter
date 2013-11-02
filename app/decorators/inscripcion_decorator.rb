# encoding: utf-8
class InscripcionDecorator < ApplicationDecorator
  decorates_association :torneo

  def dropear_link
    h.link_to object.dropeo.present? ? "En la #{object.dropeo}" : 'No',
    h.dropear_del_torneo_path(object.torneo, object),
    method: :put, remote: true, class: 'dropear'
  end

  def nombre_o_usuario
    if object.usuario.present?
      h.link_to object.participante, object.usuario
    else
      object.participante
    end
  end

  def preparar(oponente)
    partidas = if oponente.bye?
      object.torneo.sistema.class::BYE[:partidas_ganadas]
    else
      nil
    end

    object.rondas.build(
      numero: torneo.ronda_actual, oponente_id: oponente.id,
      partidas_ganadas: partidas
    )
    self
  end

  def resultado(numero)
    ronda = object.rondas.where(numero: numero).first.decorate

    "#{ronda.resultado} #{ronda.oponente} #{ronda.partidas}".html_safe
  end
end
