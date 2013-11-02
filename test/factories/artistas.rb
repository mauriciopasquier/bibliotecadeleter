# encoding: utf-8
FactoryGirl.define do
  factory :artista do
    nombre  { generate :cadena_unica }

    factory :artista_con_links do
      ignore { cantidad_de_links 1 }
      after(:build) do |artista, params|
        FactoryGirl.create_list(  :link,
                                  params.cantidad_de_links,
                                  linkeable: artista  )
      end
    end
  end
end
