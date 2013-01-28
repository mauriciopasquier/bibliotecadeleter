jQuery ->

  $('.plegable').click ->
    $(this).nextAll().toggle('fast')
    return false

  # Maneja la respuesta del controlador que pregunta xhr?
  $(document).on('ajax:success', '.pagination', (evt, data, status, xhr) ->
      $('#lista').replaceWith(data)
      history.pushState(null, '', this.href) )

  $(".alert button.close").show()
  $(".alert").alert()
