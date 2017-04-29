FactoryGirl.define do
  factory :carta do
    nombre  { generate :cadena_unica }

    # Para crear una carta con versiones
    #
    #   create :carta, :con_versiones
    #   create :carta, :con_versiones, cantidad_de_versiones: 10
    trait :con_versiones do
      transient { cantidad_de_versiones 1 }

      after(:build) do |carta, fabrica|
        create_list :version, fabrica.cantidad_de_versiones, carta: carta
      end
    end
  end
end
