# encoding: utf-8
module ArtistasHelper
  include PaginacionHelper
  
  def titulo
    case params[:action]
      when 'index'
        'Todos los artistas'
      when 'show'
        @artista.nombre
      when 'new'
        'Nuevo artista'
      when 'edit'
        @artista.nombre
      else
        nil
    end
  end
end
