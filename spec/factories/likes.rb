FactoryGirl.define do
  factory :like do
    user
    association :post, factory: :user_post
  end
end
