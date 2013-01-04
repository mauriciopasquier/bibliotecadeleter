jQuery ->

  $('.menu .plegable').click ->
    $(this).nextAll().toggle('fast')
    return false
