$(document)
  .on 'railsAutocomplete.select', '.ac-codigo', (evento, data) ->
    $(this).parent().next()
      .children('.ac-participante')
        .val(data.item.participante)

$(document)
  .on 'railsAutocomplete.select', '.ac-participante', (evento, data) ->
    $(this).parent().prev()
      .children('.ac-codigo')
        .val(data.item.codigo)
