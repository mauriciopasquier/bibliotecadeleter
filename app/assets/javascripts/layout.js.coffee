jQuery ->

  $('.plegable').click ->
    $(this).nextAll().toggle('fast')
    return false

  # muestra el botón para cerrar la flash si hay js
  $(".alert button.close").show()
  $(".alert").alert()
