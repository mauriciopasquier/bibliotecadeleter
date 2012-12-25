# encoding: utf-8
FactoryGirl.define do
  factory :carta do
    nombre  { generate :cadena_unica }
    texto   "El texto de la carta."
  end
end
