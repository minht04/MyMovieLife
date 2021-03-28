FactoryBot.define do
  factory :post do
    movie { Faker::Lorem.characters(number: 10) }
    title { Faker::Lorem.characters(number: 10) }
    details { Faker::Lorem.characters(number: 20) }
  end
end