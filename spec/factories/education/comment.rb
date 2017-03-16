FactoryGirl.define do
  factory :comment, class: Education::Comment do
    content Faker::Lorem.sentence
    user_id{User.first.id}
    commentable_id{Education::Project.first.id}
    commentable_type{Education::Project.name}
  end
end
