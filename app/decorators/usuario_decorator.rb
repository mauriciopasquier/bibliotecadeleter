# encoding: utf-8
class UsuarioDecorator < ApplicationDecorator
  # Sí...
  def cantidad_faltante
    object.faltantes.map(&:cantidad).reduce(:+).try(:abs) || 0
  end

  def cantidad_sobrante
    object.sobrantes.map(&:cantidad).reduce(:+) || 0
  end

  def antiguedad
    h.distance_of_time_in_words(usuario.created_at, Date.today)
  end

  def actual?
    h.current_usuario == object
  end

  # Si cargó un avatar, usarlo. Si no, defaultear a gravatar con default a
  # nuestro missing.png
  def algun_avatar
    if object.avatar?
      object.avatar.url
    else
      object.gravatar_url(default: object.avatar.url)
    end
  end

  def algun_avatar_tag
    h.x_image_tag(algun_avatar, alt: object.nick)
  end
end
