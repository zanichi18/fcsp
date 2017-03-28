class CompaniesController < ApplicationController
  load_resource
  def show
    respond_to do |format|
      format.html
      format.json{render json: @company.addresses}
    end
  end
end
