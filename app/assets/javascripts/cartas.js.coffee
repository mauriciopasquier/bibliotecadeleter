jQuery ->

  # mejora el estilo default de los file uploaders
  $("form.carta :file").filestyle(
    buttonText: 'Subir',
    classText: 'span9 filestyle',
    classButton: 'span3 filestyle'
  )
