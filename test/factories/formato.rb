# encoding: utf-8
FactoryGirl.define do
  factory :formato, aliases: [ :formato_objetivo ] do
    nombre        { generate :cadena_unica }
  end
end
