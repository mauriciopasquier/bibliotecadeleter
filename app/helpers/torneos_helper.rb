# encoding: utf-8
module TorneosHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'index'
        'Todos los torneos'
      when 'show', 'edit'
        torneo.identificador
      when 'new'
        'Nuevo torneo'
      when 'proximos'
        'Próximos torneos'
      when 'nueva_ronda'
        "Pairings para la ronda #{torneo.ronda_actual}"
      when 'mostrar_ronda'
        "Posiciones después de la ronda #{@ronda}"
      else
        nil
    end
  end

  def torneo
    @decorador_torneo ||= @torneo.decorate
  end

  def filtros_de_estado
    Torneo.estados.collect do |estado|
      previos = params[:estado] || []

      proximos = if previos.include? estado
        previos - [ estado ]
      else
        previos + [ estado ]
      end

      link_to estado, proximos.any? ? torneos_path(estado: proximos) : torneos_path,
        class: 'btn' + (previos.include?(estado) ? ' btn-info' : '')
    end.join.html_safe
  end
end
