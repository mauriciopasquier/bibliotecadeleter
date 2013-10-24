# encoding: utf-8
module TorneosHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'index'
        'Todos los torneos'
      when 'show'
        "#{@torneo.formato} en #{@torneo.nombre_tienda} el #{@torneo.fecha}"
      when 'new'
        'Nuevo torneo'
      when 'edit'
        @torneo.nombre
      when 'proximos'
        'Próximos torneos'
      else
        nil
    end
  end

  def torneo
    @decorador_torneo ||= @torneo.decorate
  end
end
