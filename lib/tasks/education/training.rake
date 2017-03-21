namespace :education do
  desc "create trainings & courses for education"
  task make_trainings: :environment do

    30.times do |n|
      training_params = {
        name: "Training #{n}",
        description: FFaker::Lorem.paragraph
      }

      course_params = {
        name: "Course #{n}",
        detail: FFaker::Lorem.sentence,
        training_id: 1,
        start_date: FFaker::Time.date,
        end_date: FFaker::Time.date
      }

      training = Education::Training.create! training_params
      4.times do |n|
        training.training_techniques.create technique_id: rand(1..4)
      end

      course = Education::Course.create! course_params
      course.images.create url: "/default.jpg"
      4.times do |i|
        course.course_members.create(user_id: (i+1))
      end
    end
  end
end
