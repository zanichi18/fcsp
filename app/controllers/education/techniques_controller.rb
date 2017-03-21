class Education::TechniquesController < Education::BaseController
  before_action :load_technique, only: :show

  def index
    @techniques = Education::Technique.includes(:image).page(params[:page])
      .per Settings.education.technique.per_page
  end

  def show
  end

  private

  def load_technique
    return if @technique = Education::Technique.find_by(id: params[:id])
    flash[:error] = t "education.technique.not_found"
    redirect_to education_root_path
  end
end
