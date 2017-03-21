class Education::HomeController < Education::BaseController
  def index
    @home_object = Supports::Education::Home.new
  end
end
