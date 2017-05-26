class UserPortfoliosController < ApplicationController
  before_action :authenticate_user!
  before_action :load_portfolio, only: [:edit, :destroy, :update]

  def new
    @portfolio = current_user.user_portfolios.build
    @portfolio.images.build
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def create
    @portfolio_detail = UserPortfolio.new portfolio_params
    if @portfolio_detail.save
      portfolio_js t(".success"), 200
    else
      render json: {errors: @portfolio_detail.errors}
    end
  end

  def destroy
    if @portfolio.destroy
      portfolio_js t(".success"), 200
    else
      portfolio_js t(".failed"), 400
    end
  end

  def update
    if params[:user_portfolio].present?
      if portfolio_params[:title].nil?
        update_image
      else
        update_portfolio
      end
    else
      redirect_to user_path current_user
    end
  end

  private

  def portfolio_js message, status
    @status = status
    @message = message
    respond_to do |format|
      format.js
    end
  end

  def update_image
    if @portfolio.update_attributes portfolio_params_image
      flash[:success] = t ".success"
    else
      flash[:warning] = t ".fail_image"
    end
    redirect_to user_path current_user
  end

  def update_portfolio
    if @portfolio.update_attributes portfolio_params
      portfolio_js t(".success"), 200
    else
      render json: {errors: @portfolio.errors}
    end
  end

  def portfolio_params
    params.require(:user_portfolio).permit(:title, :description, :time, :url)
      .merge user: current_user
  end

  def portfolio_params_image
    params.require(:user_portfolio).permit(images_attributes: [:id, :picture,
      :picture_cache, :_destroy]).merge user: current_user
  end

  def load_portfolio
    return if @portfolio = UserPortfolio.find_by(id: params[:id])
    flash[:error] = t ".not_found"
    redirect_to user_path current_user
  end
end
