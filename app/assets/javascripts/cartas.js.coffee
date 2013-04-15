# Hay que largarlo tanto cuando se carga la página como cuando turbolinks la
# pide (el page:change)
bindear = ->
  # mejora el estilo default de los file uploaders
  $("form.carta :file").filestyle(
    buttonText: 'Subir',
    classText: 'span9 filestyle',
    classButton: 'span3 filestyle'
  )

$(document)
  .on 'page:change', ->
    bindear()

jQuery ->
  bindear()
