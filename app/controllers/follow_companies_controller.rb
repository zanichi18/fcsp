class FollowCompaniesController < ApplicationController
  before_action :load_company, only: [:create, :destroy]

  def create
    current_user.follow @company
    render_json t(".follow"), 200
  end

  def destroy
    current_user.stop_following @company
    render_json t(".unfollow"), 200
  end

  private

  def load_company
    @company = Company.find_by id: params[:company_id]
    render_json t(".not_found"), 404 unless @company
  end

  def render_json message, status
    respond_to do |format|
      format.json{render json: {flash: message, status: status}}
    end
  end
end
