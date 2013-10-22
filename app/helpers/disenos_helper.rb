# encoding: utf-8
module DisenosHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'index'
        if @usuario == current_usuario
          'Tus diseños'
        else
          "Diseños de #{@usuario.nick}"
        end
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
    if @usuario == current_usuario
      "Tus otros diseños"
    else
      "Diseños de #{@usuario.nick}"
    end
  end

  def diseno
    @decorator ||= @diseno.decorate
  end
end
