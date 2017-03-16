namespace :education do
  desc "create projects for education"
  task make_projects: :environment do
    30.times do |i|
      project_params = {
        name: Faker::Name.name,
        description: Faker::Lorem.sentence,
        core_features: Faker::Lorem.sentence,
        release_note: Faker::Lorem.sentence,
        git_repo: "https://github.com/example-#{i + 1}",
        server_info: Faker::Lorem.sentence,
        plat_form: "Ruby",
        pm_url: "https://fportfolio.com/users/#{i + 1}"
      }

      Education::Project.create! project_params
    end
  end
end
