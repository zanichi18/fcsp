class CompaniesController < ApplicationController
  load_resource

  def show
    render json: {addresses: @company.addresses} if request.xhr?
  end
end
