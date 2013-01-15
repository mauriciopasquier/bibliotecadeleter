# encoding: utf-8
module ApplicationHelper

  def mensajes(lista)
    flashes = []
    lista.each do |tipo, mensaje|
      flashes << content_tag(:div, class: "#{alerta(tipo)}") do
        content_tag(:button, '×', class: 'close', data: { dismiss: 'alert' }) +
        content_tag(:p) { mensaje }
      end
    end
    flashes.join.html_safe
  end

  def titulo
    "Biblioteca Del Eter#{@titulo ? " | #{@titulo}" : nil}"
  end

  def expansiones(scope = :all)
    Expansion.unscoped.send scope
  end

  def artistas(scope = :all)
    Artista.unscoped.send scope
  end

  def link_to_mostrar(recurso)
    link_to recurso do
      content_tag(:i, nil, class: 'icon-zoom-in') + 'Mostrar'
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
end
