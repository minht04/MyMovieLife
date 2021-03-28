FactoryBot.define do
  factory :post do
    member
    movie { Faker::Lorem.characters(number: 10) }
    title { Faker::Lorem.characters(number: 10) }
    details { Faker::Lorem.characters(number: 20) }
  end
end