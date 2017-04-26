class CompaniesController < ApplicationController
  load_resource

  def show
    @company_jobs = @company.jobs.includes(:images)
      .page(params[:page]).per Settings.company.per_page
    render json: {
      content: render_to_string(partial: "company_jobs"),
      addresses: @company.addresses,
      } if request.xhr?
  end
end
