# encoding: utf-8
class InscripcionDecorator < ApplicationDecorator
  def nombre_o_usuario
    if object.usuario.present?
      h.link_to object.participante, object.usuario
    else
      object.participante
    end
  end
end
