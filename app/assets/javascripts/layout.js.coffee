jQuery ->

  $('.plegable').click ->
    $(this).nextAll().toggle('fast')
    return false

  # Maneja la respuesta del controlador que pregunta xhr?
  $('#paginacion')
    .live('ajax:success', (evt, data, status, xhr) ->
      $('#lista').replaceWith(data)
      $('body').css('cursor', 'auto') )
