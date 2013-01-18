# encoding: utf-8

# para falsear uploads en rack entre otras cosas
include ActionDispatch::TestProcess

FactoryGirl.define do

  sequence :cadena_unica, 'a'

  sequence :email do |n|
    "mail-numero-#{n}@falso.com"
  end
end
