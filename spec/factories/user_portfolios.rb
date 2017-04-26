FactoryGirl.define do
  factory :user_portfolio do
    title{FFaker::Lorem.sentence}
    url "http://github.com/framgia/fcsp"
    description{FFaker::Lorem.sentence}
    time "20-04-2017"
    user
  end
end
