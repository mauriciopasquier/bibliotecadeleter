$(document)
  .on 'click', '.plegable', ->
    $(this).toggleClass('plegado').nextAll().toggle('fast')
    return false

$(document)
  .on 'page:fetch', ->
    # Uso un custom css hook de jquery, está en vendor (bgpos)
    $('#cargando').animate({'backgroundPositionY': 0}, { duration: 3000 })
    $('#cargando').show()

$(document)
  .on 'page:change', ->
    $('#cargando').hide()

jQuery ->

  # muestra el botón para cerrar la flash si hay js
  $(".alert button.close").show()
  $(".alert").alert()
