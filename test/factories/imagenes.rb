# encoding: utf-8
FactoryGirl.define do
  factory :imagen do
    association :version, factory: :version_con_carta
    archivo do
      fixture_file_upload(
        Rails.root.join('test', 'assets', 'carta.jpg'), 'image/png'
      )
    end
  end
end
