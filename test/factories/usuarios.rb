# encoding: utf-8
FactoryGirl.define do
  factory :usuario do
    nick { generate :cadena_unica }
    email
    password "algún password inolvidable"
    password_confirmation { password }
    confirmed_at { DateTime.now }
  end
end
