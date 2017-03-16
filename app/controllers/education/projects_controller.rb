class Education::ProjectsController < Education::BaseController
  before_action :load_project, only: :show
  def index
    @projects = Education::Project.newest.includes(:images).page(params[:page])
      .per Settings.education.project.per_page
    @total_project = Education::Project.count
  end

  def show
    @relations = Education::Project.relation_plat_form(@project.plat_form)
      .newest.includes(:images).limit Settings.education.related_project.limit
  end

  private

  def load_project
    return if @project = Education::Project.find_by(id: params[:id])
    flash[:error] = t "education.project.not_found"
    redirect_to education_root_path
  end
end
