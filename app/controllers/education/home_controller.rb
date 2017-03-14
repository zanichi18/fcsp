class Education::HomeController < Education::BaseController
  def index
    @about = Education::About.first
  end
end
