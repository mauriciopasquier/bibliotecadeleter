bindings = ->
  # mejora el estilo default de los file uploaders
  $("form.carta :file").filestyle(
    buttonText: 'Subir'
    classInput: 'span9 filestyle'
    classButton: 'span3 filestyle btn'
    icon: false
  )

  # Siempre hay un sólo input.supertipo
  if $('input.supertipo')[0] && $('input.supertipo')[0].value != 'Demonio'
    $('.linea-de-arte.terrenal').hide()

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
  .on 'change', 'input.supertipo', (evt) ->
    if this.value == 'Demonio'
      $('.linea-de-arte.terrenal').fadeIn()
    else
      $('.linea-de-arte.terrenal').fadeOut()

$(document)
  .on 'page:change', ->
    bindings()

jQuery ->
  bindings()
