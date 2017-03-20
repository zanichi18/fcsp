require "rails_helper"
require "support/controller_helpers"

RSpec.describe Admin::CompaniesController, type: :controller do
  let!(:admin){FactoryGirl.create :user, role: 1}
  before :each do
    allow(controller).to receive(:current_user).and_return(admin)
    sign_in admin
  end

  describe "GET #new" do
    it "render new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create company" do
    it "create successfully" do
      company_params = FactoryGirl.attributes_for(:company)
      expect do
        post :create, params:
          {company: company_params}
      end.to change(Company, :count).by 1
      expect(flash[:success]).to be_present
    end

    it "create fail with name nil" do
      company_params = FactoryGirl.attributes_for(:company, name: nil)
      expect do
        post :create, params:
          {company: company_params}
      end.to change(Company, :count).by 0
      expect(flash[:danger]).to be_present
      expect(response).to render_template :new
    end

    it "create fail by reaching length limitation" do
      name = FFaker::Lorem.paragraph
      company_params = FactoryGirl.attributes_for(:company, name: name)
      expect do
        post :create, params:
          {company: company_params}
      end.to change(Company, :count).by 0
      expect(flash[:danger]).to be_present
      expect(response).to render_template :new
    end

    it "create fail with website nil" do
      company_params = FactoryGirl.attributes_for(:company, website: nil)
      expect do
        post :create, params:
          {company: company_params}
      end.to change(Company, :count).by 0
      expect(flash[:danger]).to be_present
      expect(response).to render_template :new
    end

    it "create fail with company size not numerical" do
      company_params = FactoryGirl.attributes_for(:company, company_size: "a")
      expect do
        post :create, params:
          {company: company_params}
      end.to change(Company, :count).by 0
      expect(flash[:danger]).to be_present
      expect(response).to render_template :new
    end

    it "create fail with company size negative" do
      company_params = FactoryGirl.attributes_for(:company, company_size: -1)
      expect do
        post :create, params:
          {company: company_params}
      end.to change(Company, :count).by 0
      expect(flash[:danger]).to be_present
      expect(response).to render_template :new
    end
  end
end
