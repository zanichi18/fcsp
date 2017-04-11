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
        introduction = FFaker::Lorem.paragraph
        website = FFaker::Internet.domain_name
        company_size = 100
        founder_on = FFaker::Time.datetime
        Company.create(name: name,
          introduction: introduction,
          website: website,
          founder: founder,
          company_size: company_size,
          founder_on: founder_on)
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
        user = User.create!(name: FFaker::Name.name, email: email, password:
          password)
        InfoUser.create! user_id: user.id, introduce: Faker::Lorem.paragraph
      end

      User.create! name: "Adminprp",
        email: "admin@gmail.com",
        password: "123456",
        role: 1


      User.create! name: "user",
        email: "user@gmail.com",
        password: "123456"

      puts "Create positions"
      positions = ["Manager", "Director", "Admin"]
      positions.each do |position|
        company_id = 1
        Position.create! name: position,
          company_id: company_id
      end

      puts "Create groups"
      groups = ["Education", "HR", "BO"]
      groups.each do |group|
        company_id = rand(1..2)
        description = FFaker::Lorem.sentence
        Group.create! name: group,
          company_id: company_id,
          description: description
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
      20.times.each do
        title = FFaker::Lorem.sentence
        describe = FFaker::Lorem.paragraph
        Job.create!(
          company_id: 1, title: title, describe: describe,
          type_of_candidates: 1, who_can_apply: 1, status: 1)
      end

      20.times.each do
        title = FFaker::Lorem.sentence
        describe = FFaker::Lorem.paragraph
        Job.create!(
          company_id: 1, title: title, describe: describe,
          type_of_candidates: 1, who_can_apply: 1, status: 2)
      end

      puts "Create team introduction"
      Job.all.each do |job|
        job_id = job.id
        content = FFaker::Lorem.paragraph
        title = FFaker::Lorem.sentence
        3.times.each do |n|
          TeamIntroduction.create(
            team_target_id: job_id,
            team_target_type: "Job",
            title: "Team introduction" + (n+1).to_s,
            content: content)
        end
      end

      puts "Create employee of company"
      User.all.each do |user|
        description = FFaker::Lorem.sentence
        Employee.create!(
          user_id: user.id,
          company_id: 1,
          description: description)
      end

      puts "Create addresses of company"
      Company.all.each do |company|
        address = FFaker::Address.city
        head_office = 1
        Address.create!(
          company_id: company.id,
          address: address,
          head_office: head_office)
      end

      puts "Create industries"
      (1..5).each do |i|
        name = "Industry #{i}"
        Industry.create! name: name
      end

      puts "Create company industries"
      Company.all.each do |company|
        Industry.all.each do |industry|
          CompanyIndustry.create!(
            company_id: company.id,
            industry_id: industry.id)
        end
      end

      puts "Create benefit of company"
      Company.all.each do |company|
        (1..5).each do |i|
          name = "Benefit #{i}"
          description = FFaker::Lorem.sentence
          Benefit.create!(
            company_id: company.id,
            name: name,
            description: description)
        end
      end

      puts "Create hiring type"
      (1..6).each do |i|
        name_hiring_type = "hiring type #{i}"
        description = FFaker::Lorem.sentence
        HiringType.create!(
          name: name_hiring_type,
          description: description,
          status: 1)
      end

      puts "Create job hiring type"
      Job.all.each do |job|
        HiringType.all.each do |hiring_type|
          JobHiringType.create! job_id: job.id, hiring_type_id: hiring_type.id
        end
      end

      puts "Create skills"
      6.times do
        skill_name = FFaker::Skill.tech_skills
        Skill.create name: skill_name
      end

      puts "Assign skill to user"
      User.all.each do |user|
        Skill.all.each do |skill|
          SkillUser.create! user_id: user.id, skill_id: skill.id
        end
      end

      puts "Create skills are required by jobs"
      Job.all.each do |job|
        Skill.all.each do |skill|
          JobSkill.create job_id: job.id, skill_id: skill.id
        end
      end

      puts "Create Education informations"
      Rake::Task["education:education_seeding"].invoke
    end
  end
end
