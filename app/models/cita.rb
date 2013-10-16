class Cita

  DESTRUIR = [
    'Devorar un libro de forma literal',
    'Hay ideas que no le agradan a nadie',
    'El procedimiento de censura más popular en Jemo',
    'Nungnarh en la biblioteca',
    'La solución nungnarh a un problema siempre será violenta',
    'Destruir, necesito destruir… ¡Busquen más dominios para devastar!',
    'Nadie recordará jamás tu existencia',
    'Esta civilización nunca existió',
    'Adiós, adiós para siempre',
    'Destruiré mi hogar, para encontrar uno nuevo',
    'Todos los caminos conducen al olvido',
    'Nota mental: no conjurar rituales desconocidos en la biblioteca',
    'El fuego purifica las escrituras. Sus palabras no serán compartidas jamás' ]

  CREAR = [
    'La materia es energía, al igual que el conocimiento',
    'En la biblioteca del éter el conocimiento crece como la vegetación silvestre',
    'Cambio mi riqueza por nuevo conocimiento',
    'Ya nos servirás luego...',
    'Disfruto ver como mis creaciones causan dolor',
    'La ciudad debe crecer, el bosque deberá buscar otro lugar' ]

  ACTUALIZAR = [
    'La ignorancia es penada por ley',
    'No soy el creador, solo manipulo la realidad',
    'Ahora que la tierra es mi hogar, la decorare a mi gusto',
    'Esta es tu segunda oportunidad…',
    '¿Eso es todo lo que tienes? ¡No me hagas reír!',
    'Una puerta abierta puede cruzarse en dos direcciones',
    'Lo bueno de estos artefactos, es que saben repararse solos',
    'Atrás quedaron los días donde los caminantes viajaban largas distancias por nuevas noticias' ]

  NO_ENCONTRAR = [
    'Si desconoces lo que buscas, tu batalla ya ha terminado',
    '¿Cómo ganar una batalla, si ni siquiera encuentras a tu enemigo?',
    'Hay recuerdos que no deberían ser recordados',
    'Tiempos pasados fueron grabados, en lugares difíciles de encontrar'
  ]

  def self.random_para(accion, semilla = nil)
    case accion
      when :destruir
        DESTRUIR[semilla || rand(DESTRUIR.size)]
      when :crear
        CREAR[semilla || rand(CREAR.size)]
      when :actualizar
        ACTUALIZAR[semilla || rand(ACTUALIZAR.size)]
      when :no_encontrar
        NO_ENCONTRAR[semilla || rand(NO_ENCONTRAR.size)]
      else
    end
  end
end
