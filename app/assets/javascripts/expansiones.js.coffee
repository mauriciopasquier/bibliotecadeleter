# Hay que bindear tanto cuando se carga la página como cuando turbolinks la
# pide (el page:change)
bindings = ->
  # mejora el estilo default de los file uploaders
  $("form.expansion :file").filestyle(
    buttonText: 'Subir'
    classInput: 'span9 filestyle'
    classButton: 'span3 filestyle btn'
    icon: false
  )

$(document)
  .on 'page:change', ->
    bindings()

jQuery ->
  bindings()
