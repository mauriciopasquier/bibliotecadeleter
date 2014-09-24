# encoding: utf-8
module ColeccionesHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'show'
        "La #{@tipo_de_lista} de #{@usuario.nick}"
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

  # TODO Dejar de usar strings para esto
  def ocultar_boton_si(tipo_de_lista)
    'btn' + (tipo_de_lista == @tipo_de_lista ? ' hide' : '')
  end
end
