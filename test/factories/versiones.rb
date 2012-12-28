# encoding: utf-8
FactoryGirl.define do
  factory :version do
    texto         'El texto de la carta.'
    tipo          'Aliado'
    supertipo     'Instantáneo'
    subtipo       'Humano'
    fue           { rand(10) }
    res           { rand(10) }
    senda         'Locura'
    ambientacion  'Una frase épica.'
    numero        { rand(130) }
    rareza        'E'
    coste         { rand(13) }
    canonica      false

    expansion
  end
end
