jQuery ->

  $('.plegable').click ->
    $(this).nextAll().toggle('fast')
    return false
