require "ffaker"

namespace :db do
  desc "Seeding data"
  task seeding: :environment do
    if Rails.env.production?
      puts "Do not running in 'Production' task"
    else
      %w[db:drop db:create db:migrate db:seed].each do |task|
        Rake::Task[task].invoke
      end

      puts "Create companies"
      companies = {
        "Framgia VietNam": "Kobayashi Taihei",
        "FPT software": "Hoang Nam Tien",
        "BraveBits": "Alex Ferguson",
        "VC Corp": "Vuong Vu Thang",
        "Ipcoms": "Vu Minh Tuan"
      }

      companies.each do |name, founder|
        Company.create! name: name, introduction: FFaker::Lorem.paragraph,
          website: FFaker::Internet.domain_name, founder: founder,
          company_size: 100, founder_on: FFaker::Time.datetime
      end

      puts "Create users"
      users = {
        "hoang.thi.nhung@framgia.com": "nhunghoang",
        "do.ha.long@framgia.com": "longdh",
        "do.van.nam@framgia.com": "dovannam",
        "nguyen.ha.phan@framgia.com": "phannh",
        "luu.thi.thom@framgia.com": "thomlt",
        "thuy.viet.quoc@framgia.com": "thomlt",
        "tran.anh.vu@fsramgia.com": "thomlt",
        "le.quang.canh@sframgia.com": "thomlt",
        "nguyen.ngoc.thinh@framgia.com": "thomlt",
        "tran.xuan.nam@framgia.com": "tranxuannam",
        "admin.education@framgia.com": "admin.education"
      }

      users.each do |email, password|
        user = User.create! name: FFaker::Name.name, email: email, password:
          password
        InfoUser.create! user_id: user.id, introduce: Faker::Lorem.paragraph
      end

      User.create! name: "Adminprp",
        email: "admin@gmail.com",
        password: "123456",
        role: 1

      User.create! name: "user", email: "user@gmail.com", password: "123456"

      puts "Create positions"
      positions = ["Manager", "Director", "Admin"]
      positions.each do |position|
        Position.create! name: position, company_id: 1
      end

      puts "Create groups"
      groups = ["Education", "HR", "BO"]
      groups.each do |group|
        Group.create! name: group, company_id: rand(1..2),
          description: FFaker::Lorem.sentence
      end

      puts "Create user groups"
      UserGroup.create! user_id: 12, position_id: 3, group_id: 2,
        is_default_group: true

      puts "Create company permission"
      models = ["Company", "Job", "Candidate", "TeamIntroduction"]
      models.each do |model|
        Permission.create! entry: model, group_id: 2,
          optional: {create: true, read: true, update: true, destroy: true}
      end

      puts "Create jobs"
      2.times do |i|
        20.times do
          title = FFaker::Lorem.sentence
          describe = FFaker::Lorem.paragraph
          Job.create! company_id: 1, title: title, describe: describe,
            type_of_candidates: 1, who_can_apply: 1, status: i
        end
      end

      puts "Create team introduction"
      Job.all.each do |job|
        3.times.each do |n|
          TeamIntroduction.create! team_target_id: job.id,
            team_target_type: "Job",
            title: "Team introduction #{n+1}",
            content: FFaker::Lorem.paragraph
        end
      end

      puts "Create employee of company"
      User.all.each do |user|
        Employee.create! user_id: user.id, company_id: 1,
          description: FFaker::Lorem.sentence
      end

      puts "Create addresses of company"
      Company.all.each do |company|
        Address.create! company_id: company.id,
          address: FFaker::Address.city,
          head_office: 1
      end

      puts "Create industries"
      5.times do |i|
        name = "Industry #{i}"
        Industry.create! name: name
      end

      puts "Create company industries"
      Company.all.each do |company|
        industries = Industry.order("Random()").limit(2).pluck(:id)
        industries.each do |industry|
          CompanyIndustry.create! company_id: company.id,
            industry_id: industry
        end
      end

      puts "Create benefit of company"
      benefits = ["Free snacks / lunch", "Students welcome",
        "Come visit with friends", "Weekend commitment only",
        "Foreign nationalities welcome", "Talk on Skype"]
      Company.all.each do |company|
        benefits.sample(2).each do |benefit|
          Benefit.create! company_id: company.id, name: benefit,
            description: FFaker::Lorem.sentence
        end
      end

      puts "Create hiring types"
      hiring_types = ["Entry Career Level", "Internship",
        "Experienced Career Level", "Part Time / Contract Work"]
      hiring_types.each do |hiring_type|
        HiringType.create! name: hiring_type,
          description: FFaker::Lorem.sentence,
          status: 1
      end

      puts "Create job hiring type"
      Job.all.each do |job|
        hiring_types = HiringType.order("Random()").limit(2).pluck(:id)
        hiring_types.each do |hiring_type|
          JobHiringType.create! job_id: job.id, hiring_type_id: hiring_type
        end
      end

      puts "Create skills"
      6.times do
        Skill.create name: FFaker::Skill.tech_skill
      end

      puts "Assign skill to user"
      User.all.each do |user|
        skills = Skill.order("Random()").limit(2).pluck(:id)
        skills.each do |skill|
          SkillUser.create! user_id: user.id, skill_id: skill,
          level: rand(1..6)
        end
      end

      puts "Create skills are required by jobs"
      Job.all.each do |job|
        skills = Skill.order("Random()").limit(4).pluck(:id)
        skills.each do |skill|
          JobSkill.create! job_id: job.id, skill_id: skill
        end
      end

      puts "Create request friends"
      (5..8).each do |user_id|
        Friendship.create! friendable_type: User.name, friendable_id: user_id,
          friend_id: 1, status: 0
        Friendship.create! friendable_type: User.name, friendable_id: 1,
          friend_id: user_id, status: 1
      end

      puts "Create Education informations"
      Rake::Task["education:education_seeding"].invoke
    end
  end
end
