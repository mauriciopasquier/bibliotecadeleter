# encoding: utf-8
module ExpansionesHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'index'
        'Todas las expansiones'
      when 'show'
        expansion.nombre
      when 'new'
        'Nueva expansión'
      when 'edit'
        expansion.nombre
      when 'info'
        "Detalles de #{expansion.nombre}"
      else
        nil
    end
  end

  # Para acceder al modelo decorado. Si es necesario no decorarlo, está la
  # variable de instancia
  def expansion
    @decorator ||= @expansion.decorate
  end
end
