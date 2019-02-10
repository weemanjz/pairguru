FactoryBot.define do
  factory :comment do
    user
    movie
    text { Faker::Lorem.sentence }
  end
end
