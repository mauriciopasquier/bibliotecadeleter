# encoding: utf-8
module ListasHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'index'
        'Tus listas'
      when 'show'
        @lista.nombre
      when 'new'
        'Nueva lista de cartas'
      when 'edit'
        @lista.nombre
      else
        nil
    end
  end
end
