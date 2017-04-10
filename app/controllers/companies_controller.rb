class CompaniesController < ApplicationController
  load_resource

  def show
    render json: @company.addresses if request.xhr?
  end
end
