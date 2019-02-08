FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.first_name }
    confirmed_at { Time.zone.now }
    password "password"
  end
end
