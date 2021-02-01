FactoryBot.define do
  factory :idea do
    sequence(:title){ |n| Faker::Lorem.sentence + "#{n}"}
    description{Faker::Lorem.paragraph_by_chars}
  end
end
