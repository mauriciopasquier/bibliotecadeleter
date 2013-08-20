# encoding: utf-8
module ColeccionesHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'show'
        'Tu colección'
      when 'edit'
        'Editando la colección'
      else
        nil
    end
  end
end
