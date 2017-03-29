class BookmarksController < ApplicationController
  before_action :load_job, only: [:create, :destroy]

  def create
    current_user.bookmark @job
  end

  def destroy
    current_user.unbookmark @job
  end

  private

  def load_job
    @job = Job.find_by id: params[:id]
  end
end
