FactoryGirl.define do
  factory :job do
    title{FFaker::Job.title}
    describe{FFaker::Lorem.sentence}
    who_can_apply 1
    type_of_candidates 1
    company_id 1
  end
end
