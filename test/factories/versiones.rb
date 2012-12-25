# encoding: utf-8
FactoryGirl.define do
  factory :version do
    texto         'El texto de la carta.'
    tipo          'Aliado'
    supertipo     'Instantáneo'
    subtipo       'Humano'
    fue           2
    res           1
    senda         'Locura'
    ambientacion  'Una frase épica.'
    numero        111
    rareza        'E'
    coste         2
  end
end
