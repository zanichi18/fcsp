class CompaniesCoverController < ApplicationController
  before_action :load_company, only: [:create, :update]

  def create
    @image = @company.images.build picture: params[:picture]
    if @image.save
      @company.update_attributes cover_image_id: @image.id
      flash[:success] = t "companies.cover.success"
    else
      flash[:danger] = t "companies.cover.danger"
    end
    redirect_to @company
  end

  def update
    @company.update_attributes cover_image_id: params[:image_id]
    flash[:success] = t "companies.cover.success"
    redirect_to @company
  end

  private

  def load_company
    @company = Company.find_by id: params[:id]
    unless @company
      flash[:danger] = t "companies.cover.not_found"
      redirect_to root_url
    end
  end
end
