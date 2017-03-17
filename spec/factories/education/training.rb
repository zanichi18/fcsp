FactoryGirl.define do
  factory :training, class: Education::Training do
    name Faker::Name.last_name
    description Faker::Lorem.sentence
  end
end
