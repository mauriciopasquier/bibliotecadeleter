# encoding: utf-8
module UsuariosHelper
  include PaginacionHelper
  include ResourceDeviseHelper

  def titulo
    case params[:action]
      when 'index'
        'Registro de socios'
      when 'show', 'carnet', 'panel', 'avatar'
        usuario.nick
      else
        nil
    end
  end
end
