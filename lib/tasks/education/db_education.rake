namespace :education do
  desc "Education Seeding data"
  task education_seeding: :environment do
    puts "create technique"

    6.times do
      technique = Education::Technique.create! name: "Ruby",
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

    puts "Create Education trainings"
    Rake::Task["education:make_trainings"].invoke
  end
end
