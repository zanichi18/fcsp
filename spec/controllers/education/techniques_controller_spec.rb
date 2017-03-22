require "rails_helper"
require "support/controller_helpers"

RSpec.describe Education::TechniquesController, type: :controller do
  let(:technique){FactoryGirl.create(:education_technique)}
  let!(:user){FactoryGirl.create(:user)}
  before :each do
    group = FactoryGirl.create(:education_group)
    FactoryGirl.create :education_user_group, user: user, group: group
    FactoryGirl.create :education_permission, group: group,
      entry: "Education::Technique"
    allow(controller).to receive(:current_user).and_return user
    sign_in user
  end

  describe "GET #index" do
    before{get :index}

    context "render the show template" do
      it{expect(subject).to respond_with 200}
      it do
        expect(subject).to render_with_layout "education/layouts/application"
      end
      it{expect(subject).to render_template :index}
    end

    context "populates an array of techniques" do
      it{expect(assigns(:techniques)).to eq [technique]}
    end
  end

  describe "GET #show" do
    before{get :show, params: {id: technique}}

    context "load technique success" do
      context "render the show template" do
        it{expect(subject).to respond_with 200}
        it do
          expect(subject).to render_with_layout "education/layouts/application"
        end
        it{expect(subject).to render_template :show}
      end

      context "assigns the requested technique to @technique" do
        it{expect(assigns(:technique)).to eq technique}
      end
    end

    context "cannot load technique" do
      before do
        allow(Education::Technique).to receive(:find_by).and_return(nil)
        get :show, params: {id: technique}
      end

      it "redirect to education_root_path" do
        expect(response).to redirect_to education_root_path
      end

      it "get a flash error" do
        expect(flash[:error]).to eq I18n.t("education.technique.not_found")
      end
    end
  end
end
