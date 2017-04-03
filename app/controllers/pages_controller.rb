class PagesController < ApplicationController
  before_action :load_job, only: :index

  def index
  end

  private

  def load_job
    @jobs = Job.select(:id, :title, :describe).includes :images
  end
end
