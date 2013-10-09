FactoryGirl.define do
  factory :mazo do
    nombre  { generate :cadena_unica }
    formato_objetivo
    association :principal, strategy: :build

    factory :mazo_con_demonios do
      ignore { cantidad 1 }
      after(:build) do |mazo, params|
        FactoryGirl.create_list(:slot,
                                params.cantidad,
                                inventario: mazo)
      end
    end
  end
end
