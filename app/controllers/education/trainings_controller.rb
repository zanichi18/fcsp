class Education::TrainingsController < Education::BaseController
  before_action :load_training, only: :show

  def index
    @trainings = Education::Training.newest.page(params[:page])
      .includes(:techniques).per Settings.education.trainings.per_page
  end

  def show
    @courses = @training.courses
      .limit Settings.education.trainings.courses_limit
  end

  private
  def load_training
    return if @training = Education::Training.find_by(id: params[:id])
    flash[:danger] = t ".not_found"
    redirect_to education_root_path
  end
end
