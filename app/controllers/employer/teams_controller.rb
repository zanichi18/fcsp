class Employer::TeamsController < Employer::BaseController
  load_and_authorize_resource

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
        html_job: render_to_string(partial: "team", locals: {teams: @teams},
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
      flash[:success] = t "companies.teams.create_success"
      redirect_to employer_company_teams_url
    else
      flash[:danger] = "companies.teams.fails"
      render @team
    end
  end

  def edit
  end

  def show
  end

  def update
    if @team.update_attributes team_params
      flash[:success] = t "companies.teams.create_success"
      redirect_to employer_company_teams_url
    else
      flash[:danger] = t "companies.teams.fails"
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
end
