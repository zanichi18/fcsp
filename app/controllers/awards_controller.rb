class AwardsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_award, only: [:edit, :destroy, :update]
  def edit
    respond_to do |format|
      format.js
    end
  end

  def new
    @award = current_user.awards.build

    respond_to do |format|
      format.js
    end
  end

  def create
    @award = Award.new award_params
    if @award.save
      award_js t(".success"), 200
    else
      render json: {errors: @award.errors}
    end
  end

  def destroy
    if @award.destroy
      award_js t(".success"), 200
    else
      award_js t(".failed"), 400
    end
  end

  def update
    if @award.update_attributes award_params
      award_js t(".success"), 200
    else
      render json: {errors: @award.errors}
    end
  end
  private

  def award_params
    params.require(:award).permit(:name, :time).merge! user: current_user
  end

  def award_js message, status
    @status = status
    @message = message
    respond_to do |format|
      format.js
    end
  end

  def load_award
    return if @award = Award.find_by(id: params[:id])
    flash[:error] = t ".not_found"
    redirect_to user_path current_user
  end
end
