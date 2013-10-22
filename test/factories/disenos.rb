# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :diseno do
    nombre      { generate :cadena_unica }
    fundamento  { generate :cadena_unica }
    usuario
  end
end
