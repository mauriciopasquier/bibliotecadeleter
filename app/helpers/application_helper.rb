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
    link_to recurso do
      content_tag(:i, nil, class: 'icon-zoom-in') + texto
    end
  end

  def link_to_editar(recurso)
    link_to recurso do
      content_tag(:i, nil, class: 'icon-pencil') + 'Editar'
    end
  end

  def link_to_eliminar(recurso)
    link_to recurso, method: :delete, data: { confirm: t(:confirmar) } do
      content_tag(:i, nil, class: 'icon-remove-circle') + 'Eliminar'
    end
  end

  def placeholder_del_arte
    [ cycle("Lado infernal.", "Lado terrenal."),
      "Si hay varios artistas, separalos con ','."].join(' ')
  end

  private

    def alerta(tipo)
      'alert fade in ' +
      case tipo
        when :error
          'alert-error'
        when :notice
          'alert-info'
        when :success
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
