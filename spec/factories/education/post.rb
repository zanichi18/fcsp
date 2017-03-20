FactoryGirl.define do
  factory :education_post, class: Education::Post do
    title "post title"
    content "post content"
    association :category, factory: :education_category
    user
  end
end
