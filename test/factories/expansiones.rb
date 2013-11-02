# encoding: utf-8
FactoryGirl.define do
  factory :expansion do
    nombre        { generate :cadena_unica }
    total         { rand(130) }
    saga          "Las Crónicas de Imbanna"
    lanzamiento   { 2.years.ago.to_date }
    presentacion  { 2.years.ago.to_date }
    notas         { generate :cadena_unica }
  end
end
