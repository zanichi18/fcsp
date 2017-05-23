FactoryGirl.define do
  factory :info_user do
    relationship_status 0
    introduce Faker::Lorem.paragraph
    quote Faker::Lorem.sentence
    ambition Faker::Lorem.sentence
    address Faker::Address.city
    user
  end
end
