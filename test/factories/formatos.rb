# encoding: utf-8
FactoryGirl.define do
  factory :formato do
    nombre        { generate :cadena_unica }
  end
end
