require "rails_helper"
require "support/controller_helpers"

RSpec.describe Admin::UsersController, type: :controller do
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

  describe "POST #create user" do
    it "create successfully" do
      user_params = FactoryGirl.attributes_for(:user)
      expect do
        post :create, params:
          {user: user_params}
      end.to change(User, :count).by 1
      expect(flash[:success]).to be_present
    end

    it "create fail with name nil" do
      user_params = FactoryGirl.attributes_for(:user, name: nil)
      expect do
        post :create, params:
          {user: user_params}
      end.to change(User, :count).by 0
      expect(flash[:danger]).to be_present
      expect(response).to render_template :new
    end

    it "create fail by reaching length limitation" do
      name = FFaker::Lorem.paragraph
      user_params = FactoryGirl.attributes_for(:user, name: name)
      expect do
        post :create, params:
          {user: user_params}
      end.to change(User, :count).by 0
      expect(flash[:danger]).to be_present
      expect(response).to render_template :new
    end

    it "create with email nil" do
      user_params = FactoryGirl.attributes_for(:user, email: nil)
      expect do
        post :create, params:
          {user: user_params}
      end.to change(User, :count).by 0
      expect(flash[:danger]).to be_present
      expect(response).to render_template :new
    end

    it "create with email not unique" do
      FactoryGirl.create :user, email: "a@gmail.com"
      email = "a@gmail.com"
      user_params = FactoryGirl.attributes_for(:user, email: email)
      expect do
        post :create, params:
          {user: user_params}
      end.to change(User, :count).by 0
      expect(flash[:danger]).to be_present
      expect(response).to render_template :new
    end
  end
end
