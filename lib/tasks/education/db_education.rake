require "ffaker"

namespace :db do
  desc "Education Seeding data"
  task education_seeding: :environment do
    if Rails.env.production?
      puts "Do not running in 'Production' task"
    else
      %w(db:setup).each do |task|
        Rake::Task[task].invoke
      end

      puts "create technique"

      6.times do
        technique = Education::Technique.create! name: "Ruby",
          description: Faker::Lorem.sentence
        Education::Image.create url: "/assets/education/technique/ruby.png",
          imageable_id: technique.id,
          imageable_type: Education::Technique.name
      end
    end
  end
end
