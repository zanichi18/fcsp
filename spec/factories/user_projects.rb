FactoryGirl.define do
  factory :user_project do
    title "User Project"
    url "http://github.com/framgia/fcsp"
    description "User Project Description"
    start_date "20-03-2017"
    end_date "20-05-2017"
    user
  end

  factory :invalid_user_project do
    title nil
  end
end
