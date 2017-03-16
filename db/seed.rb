Education::About.create!(name: "welcome to education framig", title: "master dev")
10.times do |n|
  name  = "training #{n}"
  desciption = "password"
  Educaiton::Training.create!(name: name, descrition: description)
end
Education::Tecnique.create!(name: "Ruby")
Education::Tecnique.create!(name: "PHP")
Education::Tecnique.create!(name: "IOS")
Education::Tecnique.create!(name: "GIT")

30.times do |n|
  technique_id = rand 1..4
  training_id = rand 1..10
  Educaiton::TrainingTechniques.create!(technique_id: technique_id, training_id: training_id)
end