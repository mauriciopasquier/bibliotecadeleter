# encoding: utf-8
FactoryGirl.define do
  factory :lista do
    nombre  { generate :cadena_unica }

    factory :lista_con_slots do
      ignore { cantidad 1 }
      after(:build) do |lista, params|
        FactoryGirl.create_list(:slot,
                                params.cantidad,
                                inventario: lista)
      end
    end

    factory :principal, class: Principal, parent: :lista

    factory :coleccion, class: Coleccion, parent: :lista
    factory :reserva, class: Reserva, parent: :lista
  end
end
