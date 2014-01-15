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
    unless $('.flechas').length == 0
      unless tecla.altKey
        switch tecla.which
          when 37 then Eter.visitar '#anterior'
          when 39 then Eter.visitar '#siguiente'

$(document)
  .on 'page:change', ->
    bindings()

jQuery ->
  bindings()
