# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :torneo do
    fecha "2013-10-22"
    tienda
    formato
    organizador
  end
end
