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
    @portfolio = UserPortfolio.new portfolio_params
    if @portfolio.save
      flash[:success] = t ".portfolio_created"
    else
      flash[:danger] = t ".portfolio_create_failed"
    end
    redirect_to user_path current_user
  end

  def destroy
    if @portfolio.destroy
      portfolio_js t(".success"), 200
    else
      portfolio_js t(".failed"), 400
    end
  end

  def update
    if @portfolio.update_attributes portfolio_params
      flash[:success] = t ".portfolio_updated"
    else
      flash[:danger] = t ".portfolio_update_failed"
    end
    redirect_to user_path current_user
  end

  private

  def portfolio_js message, status
    @status = status
    @message = message
    respond_to do |format|
      format.js
    end
  end

  def portfolio_params
    params.require(:user_portfolio).permit(:title, :description, :time, :url,
      images_attributes: [:id, :picture, :picture_cache, :_destroy])
      .merge user: current_user
  end

  def load_portfolio
    return if @portfolio = UserPortfolio.find_by(id: params[:id])
    flash[:error] = t ".not_found"
    redirect_to user_path current_user
  end
end
