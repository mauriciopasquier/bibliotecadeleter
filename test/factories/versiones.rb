# encoding: utf-8
FactoryGirl.define do
  factory :version do
    texto         'El texto de la carta.'
    tipo          'Aliado'
    supertipo     'Instantáneo'
    subtipo       'Humano'
    fue           { rand(10).to_s }
    res           { rand(10).to_s }
    senda         'Locura'
    ambientacion  'Una frase épica.'
    numero        { rand(130) }
    rareza        'Épica'
    coste         { rand(13).to_s }
    canonica      false

    expansion

    factory :version_con_carta do
      carta
    end
  end
end
