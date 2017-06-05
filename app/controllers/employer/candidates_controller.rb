class Employer::CandidatesController < Employer::BaseController
  load_resource :company
  before_action :filter_params, only: [:index, :update, :destroy]

  def index
    if params[:type]
      sort_by = params[:sort].nil? ? "ASC" : params[:sort]
      @candidates = @object.filter_candidates(params[:array_id],
        sort_by, params[:type]).page(params[:page])
        .per Settings.employer.candidates.per_page
    else
      @candidates = @object.candidates.page(params[:page])
        .per Settings.employer.candidates.per_page
    end

    if request.xhr?
      render json: {
        html_job: render_to_string(partial: "candidate",
          locals: {candidates: @candidates}, layout: false),
        pagination_candidate: render_to_string(partial: "paginate",
          layout: false, locals: {candidates: @candidates})
      }
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def update
    if params[:type]
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

  def destroy
    if check_list_candidate params[:array_id]
      if Candidate.delete_candidate params[:array_id]
        @candidates = @object.candidates.page(params[:page])
          .per Settings.employer.candidates.per_page
        if request.xhr?
          render json: {
            html_candidate: render_to_string(partial: "candidate",
              locals: {candidates: @candidates}, layout: false),
            pagination_candidate: render_to_string(partial: "paginate",
              layout: false), flash: t(".success"), status: 200
          }
        else
          respond_to do |format|
            format.html
          end
        end
      end
    else
      render_flash_json t(".warning")
    end
  end

  private

  def filter_params
    filter = params[:select].blank? ? @company.jobs.pluck(:id) : params[:select]
    @object = Supports::Candidate.new @company, filter
  end

  def check_list_candidate list_candidate
    true unless list_candidate.nil?
  end

  def render_flash_json message
    if request.xhr?
      render json: {flash: message}
    else
      respond_to do |format|
        format.html
      end
    end
  end
end
