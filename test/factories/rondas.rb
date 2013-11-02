# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ronda do
    numero { 1 + rand(7) }
    partidas_ganadas { rand(3) }

    inscripcion
  end
end
