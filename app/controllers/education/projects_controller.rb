class Education::ProjectsController < Education::BaseController
  before_action :load_project, except: [:new, :index, :create]

  def index
    @projects = Education::Project.newest.includes(:images).page(params[:page])
      .per Settings.education.project.per_page
    @total_project = Education::Project.count
  end

  def show
    @relations = Education::Project.relation_plat_form(@project.plat_form)
      .newest.includes(:images).limit Settings.education.related_project.limit
  end

  def new
    @project = Education::Project.new
  end

  def create
    @project = Education::Project.new project_params
    if @project.save
      flash[:success] = t ".project_created"
      redirect_to @project
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update_attributes project_params
      flash[:success] = t ".project_updated_successfully"
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = t ".project_deleted"
    else
      flash[:warning] = t ".project_delete_fail"
    end
    redirect_to education_root_path
  end

  private
  def project_params
    params.require(:education_project).permit :name, :description,
      :release_note, :core_features, :server_info, :pm_url, :plat_form,
      :git_repo
  end

  def load_project
    return if @project = Education::Project.find_by(id: params[:id])
    flash[:danger] = t "education.projects.project_not_found"
    redirect_to education_root_path
  end
end
