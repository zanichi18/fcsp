require "rails_helper"

RSpec.describe Education::ProjectsController, type: :controller do
  let(:project){FactoryGirl.create(:project)}
  describe "GET #index" do
    it do
      get :index
      expect(response).to have_http_status :success
    end
  end

  describe "GET #show" do
    before{get :show, params: {id: project}}

    context "load project success" do
      context "render the show template" do
        it{expect(subject).to respond_with 200}
        it do
          expect(subject).to render_with_layout "education/layouts/application"
        end
        it{expect(subject).to render_template :show}
      end

      context "assigns the requested project to @project" do
        it{expect(assigns(:project)).to eq project}
      end
    end

    context "cannot load project" do
      before do
        allow(Education::Project).to receive(:find_by).and_return(nil)
        get :show, params: {id: project}
      end

      it "redirect to education_root_path" do
        expect(response).to redirect_to education_root_path
      end

      it "get a flash error" do
        expect(flash[:error]).to eq I18n.t("education.project.not_found")
      end
    end
  end
end
