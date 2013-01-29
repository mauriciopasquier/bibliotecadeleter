jQuery ->

  # Maneja la respuesta del controlador que pregunta xhr?
  $(document)
    .on 'ajax:success', '.pagination a', (evt, data, status, xhr) ->
      # Actualiza la url
      history.pushState(null, this.href, this.href)
      $('#lista').replaceWith data

  # Intercepta el evento que larga el botón de volver para recargar el
  # contenido correcto
  if $('.pagination')
    $(window)
      .bind 'popstate', ->
        $.get location.href, (data) ->
          $('#lista').replaceWith(data)

  $(document)
    .on 'change', '.mostrar-tipo', (evt) ->
      $.get URI(location.href).removeQuery('mostrar[tipo]').addQuery('mostrar[tipo]', this.value), (data) ->
        $('#lista').replaceWith(data)
