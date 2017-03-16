namespace :education do
  desc "create projects for education"
  task make_projects: :environment do
    30.times do
      project_params = {
        name: FFaker::Product.product_name,
        description: FFaker::Lorem.sentence,
        core_features: FFaker::Lorem.sentence,
        release_note: FFaker::Lorem.sentence,
        git_repo: "https://github.com/example",
        server_info: FFaker::Lorem.sentence,
        plat_form: "Ruby",
        pm_url: "https://pm_url.com/example"
      }

      Education::Project.create! project_params
    end
  end
end
