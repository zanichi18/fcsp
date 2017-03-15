class Education::HomeController < Education::BaseController
  def index
    @about = Education::About.first
    @projects = Education::Project.newest.limit(Settings.home.limit)
  end
end
