class Employer::CandidatesController < Employer::BaseController
  load_resource :company

  def index
    if params[:select].blank?
      params[:job_id] = @company.jobs.pluck(:id)
    else
      params[:job_id] = params[:select]
    end

    @object = Supports::Candidate.new @company, params[:job_id]
    if params[:type]
      sort_by = params[:sort].nil? ? "ASC" : params[:sort]
      @candidates = @object.filter_candidates params[:array_id],
        sort_by, params[:type]
    else
      @candidates = @object.candidates
    end

    if request.xhr?
      render json: {
        html_job: render_to_string(partial: "candidate",
          locals: {candidates: @candidates}, layout: false)
      }
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def update
    if params[:type]
      if params[:select].blank?
        params[:job_id] = @company.jobs.pluck(:id)
      else
        params[:job_id] = params[:select]
      end
      @object = Supports::Candidate.new @company, params[:job_id]
      @object.change_process_status params[:id], params[:type]

      if request.xhr?
        render json: {
          type: Candidate.human_enum_name(:process, params[:type]),
          class_button: "btn btn-xs btn-" + params[:type].first,
          box_process: render_to_string(partial: "change_process",
            locals: {process: params[:type]}, layout: false)
        }
      end
    end
  end
end
