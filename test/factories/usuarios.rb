# encoding: utf-8
FactoryGirl.define do
  factory :usuario, aliases: [ :organizador ] do
    nick { generate :cadena_unica }
    nombre { generate :cadena_unica }
    email
    password 'algún password inolvidable'
    confirmed_at { DateTime.now }
  end
end
