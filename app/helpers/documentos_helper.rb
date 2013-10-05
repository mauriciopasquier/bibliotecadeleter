# encoding: utf-8
module DocumentosHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'new'
        'Búsqueda global'
      when 'index'
        "Coincidencias para '#{@busqueda}'"
      else
        nil
    end
  end
end
