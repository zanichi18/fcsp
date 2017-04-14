class Employer::CandidatesController < Employer::BaseController
  load_resource :company

  def index
    params[:job_id] = @company.jobs.pluck(:id) if params[:job_id].blank?
    @object = Supports::Candidate.new @company, params[:job_id]
    respond_to do |format|
      if request.xhr?
        format.html do
          render partial: "candidate",
          locals: {candidates: @object.candidates}
        end
      else
        format.html
      end
    end
  end
end
