href = (a, c) ->
  URI(a.href).setQuery('cantidad', c).toString()

prepararNestedFields = ->
  $('form.lista .nestear').nestedFields({
    afterInsert: (item) ->
      $(item).find('.controles-anidados').children().toggleClass('hidden')
  })
  # Si hay javascript oculta el checkbox y muestra el link remoto
  $('.controles-anidados').children().toggleClass('hidden')

$(document)
  .on 'ajax:success', '.update-listas', (evento, data, status, xhr) ->
    $(this).siblings('span.cantidad').html(data.cantidad)
    $(this).parent().children('.update-listas.agregar')
      .attr('href', href(this, data.cantidad + 1))
    $(this).parent().children('.update-listas.remover')
      .attr('href', href(this, Math.max(0, data.cantidad - 1)))

$(document)
  .on 'railsAutocomplete.select', '.autocomplete-versiones', (evento, data) ->
    # El controlador devuelve el hash con version_id explícitamente
    $(this).siblings('.version_id').val(data.item.version_id)

$(document)
  .on 'page:change', ->
    prepararNestedFields()

jQuery ->
  prepararNestedFields()
