namespace :education do
  desc "create trainings & courses for education"
  task make_trainings: :environment do
    30.times do |n|
      training_params = {
        name: "Training #{n}",
        description: FFaker::Lorem.sentence
      }

      course_params = {
        name: "Course #{n}",
        detail: FFaker::Lorem.sentence,
        training_id: 1,
        start_date: FFaker::Time.date,
        end_date: FFaker::Time.date
      }

      Education::Training.create! training_params
      Education::Course.create! course_params
    end
  end
end
