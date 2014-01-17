# encoding: utf-8
module ApplicationHelper

  def mensajes(lista)
    lista.collect do |tipo, mensaje|
      content_tag(:div, class: "#{alerta(tipo)}") do
        content_tag(:button, '×', class: 'close', data: { dismiss: 'alert' }) +
        content_tag(:p) { mensaje }
      end
    end.join.html_safe
  end

  def opciones_de_ordenar
    request.query_parameters
  end

  # Título de la página para el +<head>+ por defecto, extra se determina en el
  # helper de cada controlador, dependiendo de la acción
  def titulo_de_la_aplicacion(extra = nil)
    extra ||= titulo
    "#{extra.nil? ? nil : "#{extra} | "}Biblioteca Del Eter"
  end

  # Por defecto, no se usa nada.
  def titulo
    case c = params[:controller]
      when /^devise\//
        case a = params[:action]
          when 'edit', 'new'
            t "#{c.gsub('/','.')}.#{a}.titulo"
          else
            nil
        end
      when /^forem\//
        'Foros'
      else
        nil
    end
  end

  def expansiones
    Expansion.unscoped
  end

  def artistas
    Artista.unscoped
  end

  def cartas
    Carta.unscoped
  end

  def link_to_mostrar(recurso, texto = 'Mostrar')
    link_to recurso, title: 'Mostrar' do
      content_tag(:i, nil, class: 'icon-search') + texto
    end
  end

  def link_to_editar(recurso, texto = 'Editar')
    link_to recurso, title: 'Editar' do
      content_tag(:i, nil, class: 'icon-pencil') + texto
    end
  end

  def link_to_eliminar(recurso, texto = 'Eliminar')
    link_to recurso, method: :delete, data: { confirm: t(:confirmar) }, title: 'Eliminar' do
      content_tag(:i, nil, class: 'icon-remove') + texto
    end
  end

  def placeholder_del_arte
    [ cycle("Lado infernal.", "Lado terrenal."),
      "Si hay varios artistas, separalos con ','."].join(' ')
  end

  def busqueda
    [ versiones_tipos,
      'versiones_texto',
      'versiones_ambientacion',
      'nombre'
    ].join('_or_') + '_cont'
  end

  def versiones_tipos
    ['versiones_tipo', 'versiones_supertipo', 'versiones_subtipo'].join('_or_')
  end

  def sendas
    %w{ Caos Locura Muerte Poder Neutral }
  end

  def rarezas
    %w{ Común Infrecuente Rara Épica Promocional }
  end

  def barra_de_busqueda
    Carta.ransack
  end

  # data: no_turbolink
  def no_turbolink
    { 'no-turbolink' => true }
  end

  def usuario
    @decorador_usuario ||= @usuario.decorate
  end

  private

    def alerta(tipo)
      'alert alert-block fade in ' +
      case tipo
        when :error
          'alert-error'
        when :notice, :success
          'alert-success'
        when :alert
          '' # Usamos el estilo de .alert default
        else
          tipo
      end
    end

    # Prepara un nuevo modelo usando el decorador
    def preparar(modelo)
      modelo.decorator_class.preparar
    end
end
