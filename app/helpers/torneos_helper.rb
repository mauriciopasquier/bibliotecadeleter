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
end