# encoding: utf-8
module ExpansionesHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'index'
        'Todas las expansiones'
      when 'show'
        @expansion.nombre
      when 'new'
        'Nueva expansión'
      when 'edit'
        @expansion.nombre
      else
        nil
    end
  end
end
