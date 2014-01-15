# Cosas globales
@Eter =
  # Si el selector existe, visita su url asociada con Turbolinks
  # uso: Eter.visitar '#siguiente'
  visitar: (selector) ->
    elemento = $(selector)
    if elemento.length == 1
      Turbolinks.visit elemento.attr('href')
