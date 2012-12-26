# encoding: utf-8
FactoryGirl.define do
  factory :artista do
    nombre  { generate :cadena_unica }
    web     { generate :cadena_unica }
  end
end
