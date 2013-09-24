# Hay que bindear tanto cuando se carga la página como cuando turbolinks la
# pide (el page:change)
bindearTodo = ->
  # mejora el estilo default de los file uploaders
  $("form.carta :file").filestyle(
    buttonText: 'Subir',
    classText: 'span9 filestyle',
    classButton: 'span3 filestyle'
  )

$(document)
  .on 'page:change', ->
    bindearTodo()

jQuery ->
  bindearTodo()
