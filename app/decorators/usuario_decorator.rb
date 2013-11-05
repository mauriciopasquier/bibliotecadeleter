# encoding: utf-8
class UsuarioDecorator < ApplicationDecorator
  # Sí...
  def cantidad_faltante
    object.faltantes.map(&:cantidad).reduce(:+).try(:abs) || 0
  end

  def cantidad_sobrante
    object.sobrantes.map(&:cantidad).reduce(:+) || 0
  end

  def actual?
    h.current_usuario == object
  end
end
