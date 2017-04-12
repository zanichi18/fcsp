class JobsController < ApplicationController
  load_and_authorize_resource

  def index
    @jobs = Job.active.includes(:images, :company)
      .of_ids(JobHiringType.by_hiring_type(params[:hiring_type]))
      .search(title_cont: params[:job_search]).result.newest.page(params[:page])
      .per Settings.jobs.per_page

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @job_object = Supports::ShowJob.new @job
    render json: @job_object.company_address if request.xhr?
  end
end
