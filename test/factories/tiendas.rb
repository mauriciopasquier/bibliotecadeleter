# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tienda do
    nombre { generate :cadena_unica }
    direccion "Calle Falsa 123"
  end
end
