FactoryGirl.define do
  factory :user_social_network, class: SocialNetwork do
    social_network_type 0
    url "http://fb.com"
    association :owner, factory: :user
  end
end
