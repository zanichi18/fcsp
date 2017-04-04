class Education::TechniquesController < Education::BaseController
  before_action :load_technique, except: [:new, :index, :create]
  load_and_authorize_resource except: [:index, :show]

  def index
    @techniques = Education::Technique.newest
      .includes(:image, :translations).page(params[:page])
      .per Settings.education.technique.per_page
  end

  def show
  end

  def new
    @technique = Education::Technique.new
    @technique.build_image
    respond_to do |format|
      format.html
      format.js do
        render partial: "education/techniques/form",
          locals: {technique: @technique, button_text: t(".create_technique")},
          layout: false
      end
    end
  end

  def create
    @technique = Education::Technique.new technique_params
    if @technique.save
      flash[:success] = t ".new_success"
      redirect_to education_techniques_path
    else
      flash[:danger] = t ".new_faild"
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js do
        render partial: "education/techniques/form",
          locals: {technique: @technique, button_text: t(".update_technique")},
          layout: false
      end
    end
  end

  def update
    if @technique.update_attributes technique_params
      flash[:success] = t ".technique_updated_successfully"
      redirect_to education_techniques_path
    else
      render :edit
    end
  end

  def destroy
    if @technique.destroy
      flash[:success] = t ".technique_deleted"
    else
      flash[:warning] = t ".technique_delete_fail"
    end
    redirect_to education_techniques_path
  end

  private

  def load_technique
    return if @technique = Education::Technique.find_by(id: params[:id])
    flash[:error] = t "education.technique.not_found"
    redirect_to education_root_path
  end

  def technique_params
    params.require(:education_technique)
      .permit :name, :description, image_attributes: :url
  end
end
