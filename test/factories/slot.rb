# encoding: utf-8
FactoryGirl.define do
  factory :slot do
    cantidad  { rand(100) }
    version_con_carta
  end
end
