# Hay que bindear tanto cuando se carga la página como cuando turbolinks la
# pide (el page:change)
bindearTodo = ->
  # muestra el botón para cerrar la flash si hay js
  $('.alert button.close').show()
  $('.alert').alert()

  $('input.fecha').datepicker({
    language: 'es',
    format: 'yyyy/mm/dd'
  })

  $('select').selectpicker()

  $('img.lazy').lazyload()

  $('form .nestear').nestedFields({
    afterInsert: (item) ->
      $(item).find('.controles-anidados').children().toggleClass('hidden')
  })
  # Si hay javascript oculta el checkbox y muestra el link remoto
  $('.controles-anidados').children().toggleClass('hidden')

  # mejora el estilo default de los file uploaders
  $("form :file").filestyle(
    buttonText: 'Subir',
    classText: 'span9 filestyle',
    classButton: 'span3 filestyle'
  )

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
    bindearTodo()

jQuery ->
  bindearTodo()
