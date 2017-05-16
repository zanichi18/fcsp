class Employer::CompaniesController < Employer::BaseController
  load_and_authorize_resource
  before_action :load_address, :load_industry, only: :edit

  def edit
    @company.images.build
  end

  def update
    if @company.update_attributes company_params
      flash[:success] = t ".company_updated"
      type = :success
    else
      flash[:danger] = t ".company_update_fail"
      type = :danger
    end

    render json: {
      flash: {
        type: type
      }
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
