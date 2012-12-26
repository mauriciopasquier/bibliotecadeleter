# encoding: utf-8
FactoryGirl.define do
  sequence :cadena_unica, 'a'

  sequence :email do |n|
    "mail-numero-#{n}@falso.com"
  end
end
