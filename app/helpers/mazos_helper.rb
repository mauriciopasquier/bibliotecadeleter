# encoding: utf-8
module MazosHelper
  include ListasHelper

  def titulo
    case params[:action]
      when 'index'
        'Tus mazos'
      when 'show'
        mazo.nombre
      when 'new'
        'Nuevo mazo'
      when 'edit'
        mazo.nombre
      else
        nil
    end
  end

  alias_method :mazo, :lista
end
