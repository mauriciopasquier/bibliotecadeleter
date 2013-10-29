# encoding: utf-8
class InscripcionDecorator < ApplicationDecorator
  decorates_association :torneo

  def nombre_o_usuario
    if object.usuario.present?
      h.link_to object.participante, object.usuario
    else
      object.participante
    end
  end

  def preparar(oponente_id)
    object.rondas.build(
      numero: torneo.ronda_actual, oponente_id: oponente_id
    )
    self
  end
end
