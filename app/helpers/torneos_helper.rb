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
      when 'jugar'
        "Pairings para la ronda #{torneo.ronda_actual}"
      else
        nil
    end
  end

  def torneo
    @decorador_torneo ||= @torneo.decorate
  end
end
