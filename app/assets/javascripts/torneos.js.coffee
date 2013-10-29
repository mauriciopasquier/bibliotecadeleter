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

$(document)
  .on 'click', '.puntuar .btn', (evento) ->
    padre = $(this).parents('.pairing')
    padre.find('.puntos.a')
      .val($(this).data('a'))
    padre.find('.puntos.b')
      .val($(this).data('b'))

$(document)
  .on 'ajax:success', 'a.dropear', (evento, data, status, xhr) ->
    $(this).html(if data.dropeo then 'Sí' else 'No')
