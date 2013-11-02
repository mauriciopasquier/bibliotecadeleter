href = (a, c) ->
  URI(a.href).setQuery('cantidad', c).toString()

$(document)
  .on 'ajax:success', '.update-listas', (evento, data, status, xhr) ->
    $(this).siblings('span.cantidad').html(data.cantidad)
    $(this).parent().children('.update-listas.agregar')
      .attr('href', href(this, data.cantidad + 1))
    $(this).parent().children('.update-listas.remover')
      .attr('href', href(this, Math.max(0, data.cantidad - 1)))

$(document)
  .on 'railsAutocomplete.select', '.autocomplete-versiones', (evento, data) ->
    # El controlador devuelve el hash con version_id como 'id'
    $(this).siblings('.version_id').val(data.item.id)
