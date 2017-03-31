class Employer::DashboardsController < Employer::BaseController
  before_action :load_company, only: :index

  def index
  end

  private

  def load_company
    @company = Company.find_by id: params[:company_id]
  end
end
