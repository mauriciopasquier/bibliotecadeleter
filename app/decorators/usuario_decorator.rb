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
    h.distance_of_time_in_words(usuario.created_at, DateTime.now)
  end

  def actual?
    h.current_usuario == object
  end

  # Si cargó un avatar, usarlo. Si no, defaultear a gravatar con default a
  # nuestro missing.png
  def algun_avatar(estilo = :arte)
    if object.avatar?
      object.avatar.url(estilo)
    else
      object.gravatar_url(
        default: h.request.base_url + object.avatar.url(estilo),
        size: object.estilos[estilo].split('x').first
      )
    end
  end

  # FIXME deprecate segundo argumento
  def algun_avatar_tag(estilo = :arte, lazy = 'lazy')
    [ h.image_tag(algun_avatar(estilo), alt: object.nick, class: lazy, lazy: true),

      h.content_tag(:noscript) do
        h.rails_image_tag(algun_avatar(estilo), alt: object.nick)
      end
    ].join.html_safe
  end

  def medallas
    object.medallas.collect do |medalla|
      h.content_tag :span, class: 'badge badge-inverse' do
        medalla.name
      end
    end.join(' ').html_safe
  end

  def nombre_o_nick
    object.nombre.present? ? object.nombre : object.nick
  end
end
