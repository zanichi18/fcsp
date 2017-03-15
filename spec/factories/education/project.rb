FactoryGirl.define do
  factory :project, class: Education::Project do |f|
    f.name Faker::Name.last_name
    f.description Faker::Lorem.sentence
  end
end
