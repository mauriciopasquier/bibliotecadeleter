# encoding: utf-8
module ColeccionesHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'show'
        "La colección de #{@usuario.nick}"
      when 'sobrantes'
        "La basura que le sobra a #{@usuario.nick}"
      when 'faltantes'
        "¡#{@usuario.nick} necesita todo esto!"
      when 'edit'
        '¿Cómo editar la reserva y la colección?'
      else
        nil
    end
  end

  def coleccion
    @decorador_coleccion ||= @coleccion.decorate
  end
end
