class JobsController < ApplicationController
  load_and_authorize_resource

  def index
    @jobs = Job.active.includes(:images, :company).newest.page(params[:page])
      .per Settings.jobs.per_page
  end

  def show
    @job_object = Supports::ShowJob.new @job
    render json: @job_object.company_address if request.xhr?
  end
end
