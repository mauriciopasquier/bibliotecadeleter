# encoding: utf-8
module BusquedasHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'new'
        'Búsqueda global'
      when 'show'
        @texto.present? ? "Coincidencias para '#{@texto}'" : 'Búsqueda global'
      else
        nil
    end
  end
end
