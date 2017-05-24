FactoryGirl.define do
  factory :user_language do
    user
    language
    level "native"
  end
end
