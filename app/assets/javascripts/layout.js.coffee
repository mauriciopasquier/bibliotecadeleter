jQuery ->

  $(document)
    .on 'click', '.plegable', ->
      $(this).toggleClass('plegado').nextAll().toggle('fast')
      return false

  # muestra el botón para cerrar la flash si hay js
  $(".alert button.close").show()
  $(".alert").alert()
