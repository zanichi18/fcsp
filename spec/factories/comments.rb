FactoryGirl.define do
  factory :comment_user_post, class: Comment do
    content "MyString"
    user
    association :post, factory: :user_post
  end
end
