jQuery ->

  $(document)
    .on 'change', '.mostrar-tipo', (evt) ->
      url = URI(location.href).removeQuery('mostrar[tipo]').addQuery('mostrar[tipo]', this.value)
      Turbolinks.visit(url.toString())
