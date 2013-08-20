$(document)
  .on 'change', '.mostrar-tipo select', (evt) ->
    url = URI(location.href).setQuery('mostrar[tipo]', this.value)
    Turbolinks.visit(url.toString())
