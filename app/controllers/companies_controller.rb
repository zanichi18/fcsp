class CompaniesController < ApplicationController
  load_resource

  def show
    @company_jobs = @company.jobs.includes(:images)
      .page(params[:page]).per Settings.company.per_page
    if request.xhr?
      render json: {
        content: render_to_string(partial: "company_jobs"),
        addresses: @company.addresses
      }
    end
  end
end
