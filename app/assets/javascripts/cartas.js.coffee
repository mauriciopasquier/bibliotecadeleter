# Hay que largarlo tanto cuando se carga la página como cuando turbolinks la
# pide (el page:change)
bindear = ->
  # mejora el estilo default de los file uploaders
  $("form.carta :file").filestyle(
    buttonText: 'Subir',
    classText: 'span9 filestyle',
    classButton: 'span3 filestyle'
  )

  # carga las imágenes de a poco
  $('img.imagen').lazyload()

$(document)
  .on 'page:change', ->
    bindear()

jQuery ->
  bindear()
