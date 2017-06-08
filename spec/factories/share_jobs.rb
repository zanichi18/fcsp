FactoryGirl.define do
  factory :share_job do
    user_id user
    shareable_id 1
    shareable_type "Job"
  end
end
