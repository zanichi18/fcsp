FactoryGirl.define do
  factory :user_link do
    user
    link "http://google.com"
  end
end
