class PagesController < ApplicationController
  def index
    @jobs = Job.active.newest.includes(:images, company: :images)
      .page(params[:page]).per Settings.jobs.per_page
  end
end
