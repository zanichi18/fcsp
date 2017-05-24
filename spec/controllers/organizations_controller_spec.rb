require "rails_helper"

RSpec.describe OrganizationsController, type: :controller do
  describe "GET #show" do
    let!(:organization){FactoryGirl.create :organization}
    let!(:company){FactoryGirl.create :company}
    it "organization not found" do
      get :show, params: {id: 0}
      expect(response).to redirect_to root_path
    end
    it "redriect to company page if org is real company" do
      org = Organization.last
      get :show, params: {id: org.id}
      expect(response).to redirect_to company
    end
    it "redriect to org if org is unreal company" do
      get :show, params: {id: organization.id}
      expect(response).to have_http_status 200
    end
  end
end
