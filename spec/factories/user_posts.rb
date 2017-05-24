FactoryGirl.define do
  factory :user_post, class: Post do
    title "test"
    content "this is content"
    association :postable, factory: :user
  end
end
