namespace :education do
  desc "Education Seeding data"
  task education_seeding: :environment do
    puts "create technique"

    6.times do
      technique = Education::Technique.create! name: Faker::Name.last_name,
        description: Faker::Lorem.sentence
      Education::Image.create url: "/assets/education/technique/ruby.png",
        imageable_id: technique.id,
        imageable_type: Education::Technique.name
    end

    puts "create learning program"

    Education::LearningProgram.create!(name: "NEW DEV",
      description: Faker::Lorem.sentence)
    Education::LearningProgram.create!(name: "INTERN",
      description: Faker::Lorem.sentence)
    Education::LearningProgram.create!(name: "OPEN EDUCATION",
      description: Faker::Lorem.sentence)

    puts "create About"
    Education::About.create!(title: "Welcome to Framgia Education",
      content: "Master your skill. Come with us")

    puts "Create Education projects"
    Rake::Task["education:make_projects"].invoke

    puts "create project_technology"
    technique = Education::Technique.count
    Education::Project.all.each do |project|
      Education::ProjectTechnique.create project_id: project.id,
        technique_id: rand(1..technique)
    end

    puts "Create Education trainings"
    Rake::Task["education:make_trainings"].invoke

    puts "Create Education categories"
    Rake::Task["education:make_categories"].invoke

    puts "Create Education posts"
    Rake::Task["education:make_posts"].invoke

    puts "Create education group user"
    groups = ["Trainer", "Trainee"]
    groups.each do |group|
      Education::Group.create name: group
    end

    puts "Create education group of user"
    Education::UserGroup.create user_id: 1, group_id: 1
    Education::UserGroup.create user_id: 2, group_id: 2

    puts "Create education permission"
    entries = ["Education::Project", "Education::Training", "Education::Course",
      "Education::Technique", "Education::CourseMember"]
    entries.each do |entry|
      Education::Permission.create entry: entry, group_id: 1,
        optional: {create: true, read: true, update: true, destroy: true}
    end
  end
end
