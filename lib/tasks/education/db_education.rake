require "ffaker"

namespace :db do
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
    puts "Create education category"
    categories = ["Development", "Design", "QA", "Others"]
    categories.each do |category|
      Education::Category.create! name: category
    end

    puts "Create education posts"
    5.times do
      Education::Post.create! title: FFaker::Lorem.sentence,
        content: FFaker::Lorem.paragraph, category_id: 1, user_id: 1
    end
  end
end
