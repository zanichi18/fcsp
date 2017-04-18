class PagesController < ApplicationController
  def index
    @jobs = Job.active.newest.includes(:company, :images)
      .page(params[:page]).per Settings.jobs.per_page
  end
end
