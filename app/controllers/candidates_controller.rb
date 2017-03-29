class CandidatesController < ApplicationController
  before_action :load_job, only: [:create, :destroy]

  def create
    current_user.apply_job @job
  end

  def destroy
    current_user.unapply_job @job
  end

  private

  def load_job
    @job = Job.find_by id: params[:id]
  end
end
