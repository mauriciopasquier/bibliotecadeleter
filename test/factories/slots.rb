# encoding: utf-8
FactoryGirl.define do
  factory :slot do
    cantidad  { rand(100) }
    association :version, factory: :version_con_carta
    association :inventario, factory: :lista
  end
end
