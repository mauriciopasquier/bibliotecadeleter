# encoding: utf-8
module FormatosHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'index'
        'Todos los formatos'
      when 'show'
        @formato.nombre
      when 'new'
        'Nuevo formato'
      when 'edit'
        @formato.nombre
      else
        nil
    end
  end

  def formato
    @decorador_formato ||= @formato.decorate
  end
end
