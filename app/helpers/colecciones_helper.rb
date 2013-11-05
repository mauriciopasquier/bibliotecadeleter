# encoding: utf-8
module ColeccionesHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'show'
        'Tu colección'
      when 'sobrantes'
        'Esta basura te sobra'
      when 'faltantes'
        '¡Hay que conseguir todo esto!'
      when 'edit'
        '¿Cómo editar la reserva y la colección?'
      else
        nil
    end
  end
end
