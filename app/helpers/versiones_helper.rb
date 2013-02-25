# encoding: utf-8
module VersionesHelper
  def titulo
    case params[:action]
      when 'index'
        @carta.nombre
      when 'show'
        "#{@carta.nombre} de #{@version.expansion.nombre}"
      when 'new'
        "Nueva versión"
      when 'edit'
        "Editar #{@carta.nombre} de #{@version.expansion.nombre}"
      else
        nil
    end
  end
end
