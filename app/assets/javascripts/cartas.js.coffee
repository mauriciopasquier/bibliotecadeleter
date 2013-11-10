bindings = ->
  # mejora el estilo default de los file uploaders
  $("form.carta :file").filestyle(
    buttonText: 'Subir'
    classInput: 'span9 filestyle'
    classButton: 'span3 filestyle btn'
    icon: false
  )

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

$(document)
  .on 'page:change', ->
    bindings()

jQuery ->
  bindings()
