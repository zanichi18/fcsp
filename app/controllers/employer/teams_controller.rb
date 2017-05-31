class Employer::TeamsController < Employer::BaseController
  before_action :load_company, only: [:index, :new, :create]
  before_action :load_team, except: [:index, :new, :create]

  def index
    if params[:type]
      listarr = params[:array_id]
      listarr = listarr.split(",").map(&:to_i) if listarr.class == String
      sort_by = params[:sort].nil? ? "ASC" : params[:sort]
      @teams = @company.teams.includes(:images)
        .filter(listarr, sort_by, params[:type])
        .page(params[:page]).per Settings.employer.team.per_page
    else
      @teams = @company.teams.includes(:images).page(params[:page])
        .per Settings.employer.team.per_page
    end

    if request.xhr?
      render json: {
        html_job: render_to_string(partial: "team", teams: @teams,
          layout: false),
        pagination_job: render_to_string(partial: "paginate", layout: false)
      }
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def new
    @team = @company.teams.build
    @team.images.build
    @team.team_introductions.build
  end

  def create
    @team = @company.teams.build team_params
    if @team.save
      flash[:success] = t ".create_success"
      redirect_to employer_company_teams_url
    else
      flash[:danger] = ".create_fail"
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @team.update_attributes team_params
      flash[:success] = t ".update_success"
      redirect_to employer_company_teams_url
    else
      flash[:danger] = t ".update_fail"
      redirect_back fallback_location: :back
    end
  end

  def destroy
    @team.destroy
    redirect_to employer_company_teams_url
  end

  private

  def team_params
    params.require(:team).permit Team::ATTRIBUTES
  end

  def load_company
    return if @company = Company.find_by(id: params[:company_id])
    flash[:danger] = t ".not_found"
    redirect_to employer_company_teams_path
  end

  def load_team
    return if @team = Team.find_by(id: params[:id])
    flash[:danger] = t ".not_found"
    redirect_to employer_company_teams_path
  end
end
