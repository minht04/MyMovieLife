FactoryBot.define do
  factory :comment do
    member
    post
    body { Faker::Lorem.characters(number: 20) }
  end
end
