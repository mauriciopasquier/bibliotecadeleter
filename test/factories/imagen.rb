# encoding: utf-8
FactoryGirl.define do
  factory :imagen do
    association :version, factory: :version_con_carta
  end
end
