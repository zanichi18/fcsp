class Employer::JobsController < Employer::BaseController
  load_and_authorize_resource
  before_action :load_company, only: :create

  def create
    @job = @company.jobs.create job_params
    if @job.save
      flash[:success] = t ".created_job"
      redirect_to employer_company_jobs_path(@company)
    else
      flash[:danger] = t ".create_job_fail"
      redirect_to :back
    end
  end

  private

  def job_params
    params.require(:job).permit Job::ATTRIBUTES
  end

  def load_company
    @company = Company.find_by id: params[:company_id]
    not_found unless @company
  end
end
