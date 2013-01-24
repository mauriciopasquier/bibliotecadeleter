jQuery ->

  $('.plegable').click ->
    $(this).nextAll().toggle('fast')
    return false

  # Maneja la respuesta del controlador que pregunta xhr?
  $(document).on('ajax:success', '#paginacion', (evt, data, status, xhr) ->
      $('#lista').replaceWith(data)
      $('body').css('cursor', 'auto') )

  $(".alert button.close").show()
  $(".alert").alert()
