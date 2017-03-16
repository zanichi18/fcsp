namespace :education do
  desc "create projects for education"
  task make_projects: :environment do
    30.times do |i|
      project_params = {
        name: Faker::Name.name,
        description: Faker::Lorem.paragraphs(rand 5..8).join(""),
        core_features: Faker::Lorem.paragraphs(rand 5..8).join(""),
        release_note: Faker::Lorem.paragraphs(rand 5..8).join(""),
        git_repo: "https://github.com/example-#{i + 1}",
        server_info: Faker::Lorem.sentence,
        plat_form: Faker::Lorem.sentence,
        pm_url: "https://fportfolio.com/users/#{i + 1}"
      }

      Education::Project.create! project_params
    end
  end
end
