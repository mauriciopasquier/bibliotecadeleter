# encoding: utf-8
FactoryGirl.define do
  factory :link do
    url  { generate :cadena_unica }
  end
end
