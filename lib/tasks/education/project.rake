namespace :education do
  desc "create projects for education"
  task make_projects: :environment do
    30.times do
      project_params = {
        name: FFaker::Product.product_name,
        description: FFaker::Lorem.paragraphs,
        core_features: FFaker::Lorem.paragraphs,
        release_note: FFaker::Lorem.paragraphs,
        git_repo: "https://github.com/example",
        server_info: FFaker::Lorem.sentence,
        plat_form: FFaker::Lorem.sentence
      }

      Education::Project.create! project_params
    end
  end
end
