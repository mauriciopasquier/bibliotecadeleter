# encoding: utf-8
module DisenosHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'index'
        usuario.actual? ? 'Tus diseños' : "Diseños de #{@usuario.nick}"
      when 'show'
        diseno.nombre
      when 'new'
        'Nuevo diseño'
      when 'edit'
        diseno.nombre
      else
        nil
    end
  end

  def otros_disenos
    usuario.actual? ? 'Tus otros diseños' : "Diseños de #{@usuario.nick}"
  end

  def diseno
    @decorator ||= @diseno.decorate
  end
end
