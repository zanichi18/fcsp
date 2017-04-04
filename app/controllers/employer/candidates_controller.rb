class Employer::CandidatesController < Employer::BaseController
  load_resource :company

  def index
    @object = Supports::Candidate.new @company
    respond_to do |format|
      if request.xhr?
        params[:job_id] = @company.jobs.pluck(:id) if params[:job_id].empty?
        format.html do
          render partial: "candidate",
          locals: {candidates: @object.candidates.in_job(params[:job_id])}
        end
      else
        format.html
      end
    end
  end
end
