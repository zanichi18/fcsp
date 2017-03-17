class Admin::CompaniesController < Admin::BaseController
  load_and_authorize_resource

  def new
    @company = Company.new
  end

  def show
  end

  def create
    @company = Company.new company_params
    if @company.save
      flash[:success] = t ".company_created"
      redirect_to [:admin, @company]
    else
      flash[:danger] = t ".company_failed"
      render :new
    end
  end

  private

  def company_params
    params.require(:company).permit Company::ATTRIBUTES
  end
end
