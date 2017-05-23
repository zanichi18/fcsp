FactoryGirl.define do
  factory :skill do
    name{FFaker::Skill.tech_skills}
    description{FFaker::Lorem.sentence}
  end
end
