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

  # Para el FormBuilder
  def nueva_version
    if @nueva_version
      @nueva_version
    else
      @nueva_version = @carta.canonica.amoeba_dup
      @carta.canonica.imagenes.each do |i|
        @nueva_version.imagenes.build arte: i.arte
      end
      @nueva_version = @nueva_version.decorate
    end
  end

  def carta
    @decorador_carta ||= @carta.decorate
  end

  def version
    @decorador_version ||= @version.decorate
  end
end
