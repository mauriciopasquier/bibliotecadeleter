# encoding: utf-8
FactoryGirl.define do
  factory :carta do
    nombre  { generate :cadena_unica }

    factory :carta_con_versiones do
      ignore { cantidad_de_versiones 1 }
      after(:build) do |carta, params|
        FactoryGirl.create_list(  :version,
                                  params.cantidad_de_versiones,
                                  carta: carta  )
      end
    end
  end
end
