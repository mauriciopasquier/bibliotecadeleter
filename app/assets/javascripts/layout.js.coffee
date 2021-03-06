# Hay que bindear tanto cuando se carga la página como cuando turbolinks la
# pide (el page:change)
bindings = ->
  # muestra el botón para cerrar la flash si hay js
  $('.alert button.close').show()
  $('.alert').alert()

  $('input.fecha').datepicker({
    language: 'es',
    format: 'yyyy/mm/dd'
  })

  $('select').selectpicker()

  $('img.lazy').show().lazyload({
    threshold: 250
    effect: 'fadeIn'
  })

  $('form .nestear').nestedFields({
    afterInsert: (item) ->
      $(item).find('.controles-anidados').children().toggleClass('hidden')
  })
  # Si hay javascript oculta el checkbox y muestra el link remoto
  $('.controles-anidados').children().toggleClass('hidden')

  # mejora el estilo default de los file uploaders
  $("form.upload-normal :file").filestyle(
    buttonText: 'Subir'
    classInput: 'filestyle'
    classButton: 'filestyle btn'
    icon: false
  )

$(document)
  .on 'page:fetch', ->
    # Uso un custom css hook de jquery, está en vendor (bgpos)
    $('#cargando').animate({'backgroundPositionY': 0}, { duration: 3000 })
    $('#cargando').show()

$(document)
  .on 'page:change', ->
    $('#cargando').hide()
    bindings()

jQuery ->
  bindings()
