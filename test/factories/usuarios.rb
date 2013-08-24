# encoding: utf-8
FactoryGirl.define do
  factory :usuario do
    nick { generate :cadena_unica }
    email
    password "algún password inolvidable"
    confirmed_at { DateTime.now }

    unlock_token          { generate :cadena_unica }
    reset_password_token  { generate :cadena_unica }
    confirmation_token    { generate :cadena_unica }
  end
end
