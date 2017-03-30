class Education::TrainingsController < Education::BaseController
  before_action :load_training, except: [:new, :index, :create]
  load_and_authorize_resource except: [:index, :show]

  def index
    param_q = params[:q]
    param_technique_name = params[:technique_name]
    param_page = params[:page]

    @training_object = Supports::Education::Training.new param_q,
      param_technique_name, param_page
  end

  def show
    @courses = @training.courses
      .limit Settings.education.trainings.courses_limit
  end

  def new
    @training = Education::Training.new
  end

  def create
    @training = Education::Training.new training_params
    if @training.save
      flash[:success] = t ".training_created"
      redirect_to education_trainings_path
    else
      flash[:danger] = t ".training_create_failed"
      render :new
    end
  end

  def edit
  end

  def update
    if @training.update_attributes training_params
      flash[:success] = t ".training_updated_successfully"
      redirect_to @training
    else
      render :edit
    end
  end

  def destroy
    if @training.destroy
      @trainings = Education::Training.newest
      respond_to do |format|
        format.html do
          redirect_to education_trainings_path
          flash[:success] = t ".deleted_success"
        end
        format.json{render json: {flash: t(".deleted_success"), status: 200}}
      end
    else
      flash[:danger] = t ".training_delete_fail"
      redirect_to education_trainings_path
    end
  end

  private

  def load_training
    return if @training = Education::Training.find_by(id: params[:id])
    flash[:error] = t "education.trainings.training_not_found"
    redirect_to education_root_path
  end

  def training_params
    params.require(:education_training).permit :name, :description
  end
end
