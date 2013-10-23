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

# TODO bindear 36 = inicio y 35 = fin para primera y última carta
# TODO testear que estén los tags
$(document)
  .on 'keydown', (tecla) ->
    Turbolinks.visit((
      unless tecla.altKey
        switch tecla.which
          when 37 then $('#anterior')
          when 39 then $('#siguiente')
        ).attr('href'))

jQuery ->
  bindearTodo()
