class Education::TrainingsController < Education::BaseController
  def index
    @trainings = Education::Training.newest.page(params[:page])
      .includes(:techniques).per Settings.education.trainings.per_page
  end
end
