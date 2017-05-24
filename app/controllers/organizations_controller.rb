class OrganizationsController < ApplicationController
  before_action :load_organization, only: :show

  def show
    check_organization
    @related_orgs = Organization.except_org(@org)
      .of_ids(UserWork.related_org_ids_of(@org).pluck :organization_id)
    @new_jobs = Job.includes(:images, :company).newest
      .limit Settings.organization.new_job
  end

  private

  def load_organization
    return if @org = Organization.find_by(id: params[:id])
    flash[:danger] = t ".org_not_found"
    redirect_to root_path
  end

  def check_organization
    return unless @company = Company.find_by(name: @org.name)
    redirect_to @company
  end
end
