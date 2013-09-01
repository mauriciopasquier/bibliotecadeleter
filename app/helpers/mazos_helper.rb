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

  def separador_por_tipo(version)
    unless @ultimo == version.tipo
      @ultimo = version.tipo
      content_tag(:p, version.tipo, class: 'titulo-tipo')
    end
  end

  alias_method :mazo, :lista
end
