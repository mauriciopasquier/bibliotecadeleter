# Cosas globales
@Eter =
  visitar: (selector) ->
    elemento = $(selector)
    if elemento.length == 1
      Turbolinks.visit elemento.attr('href')
