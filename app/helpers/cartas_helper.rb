# encoding: utf-8
module CartasHelper
  include PaginacionHelper

  def titulo
    case params[:action]
      when 'index'
        'Todas las cartas'
      when 'show'
        @carta.nombre
      when 'new'
        'Nueva carta'
      when 'edit'
        @carta.nombre
      when 'buscar'
        'Búsqueda de cartas'
      else
        nil
    end
  end

  # Para el FormBuilder
  # TODO usar .preparar?
  def nueva_version
    if @version
      @version
    else
      @version = @carta.versiones.build
      2.times { @version.imagenes.build }
      @version = @version.decorate
    end
  end

  # Nada bloqueado en el form de cartas
  def bloqueados
    [ ]
  end

  def carta
    @decorador_carta ||= @carta.decorate
  end

  def version
    @decorador_version ||= @version.decorate
  end

  def campos_de_busqueda
    { 'Nombre'          =>  'nombre',
      'Línea de Tipos'  =>  versiones_tipos,
      'Texto'           =>  'versiones_texto',
      'Ambientación'    =>  'versiones_ambientacion' }
  end

  # Revisa el hash params para determinar qué opciones fueron seleccionadas en
  # la última búsqueda
  def seleccionadas(grupo)
    case grupo
      when :senda
        params[:q][:versiones_senda_eq_any] if params[:q].present?
      when :rareza
        params[:q][:versiones_rareza_eq_any] if params[:q].present?
      when :expansion
        params[:q][:versiones_expansion_id_eq_any] if params[:q].present?
      when :campo
        params[:incluir]
    end
  end
end
