# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :torneo do
    fecha "2013-10-22"
    tienda
    formato
    organizador

    factory :torneo_con_inscriptos do
      transient { cantidad 1 }
      after(:build) do |torneo, params|
        FactoryGirl.create_list(:inscripcion,
                                params.cantidad, torneo: torneo)
      end
    end
  end
end
