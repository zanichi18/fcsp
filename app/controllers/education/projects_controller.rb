class Education::ProjectsController < Education::BaseController
  def index
    @projects = Education::Project.newest.page(params[:page])
      .per Settings.education.project.per_page
    @total_project = Education::Project.count
  end
end
