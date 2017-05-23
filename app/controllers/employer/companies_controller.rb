class Employer::CompaniesController < Employer::BaseController
  load_and_authorize_resource
  before_action :load_address, :load_industry, only: :edit

  def edit
    @company.images.build
  end

  def update
    status = @company.update_attributes(company_params) ? :created : :failed
    render json: {
      status: status
    }
  end

  private

  def company_params
    params.require(:company).permit Company::ATTRIBUTES
  end

  def load_address
    @address = @company.addresses.head_office.first
  end

  def load_industry
    @industries = Industry.all
  end
end
