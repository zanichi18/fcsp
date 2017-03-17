require "rails_helper"

RSpec.describe Education::TrainingsController, type: :controller do
  let(:training){FactoryGirl.create :training}
  describe "GET #index" do
    it do
      get :index
      expect(response).to have_http_status :success
    end
  end

  describe "GET #show" do
    before{get :show, params: {id: training}}

    context "load training success" do
      context "render the show template" do
        it{expect(subject).to respond_with 200}
        it do
          expect(subject).to render_with_layout "education/layouts/application"
        end
        it{expect(subject).to render_template :show}
      end

      context "assigns the requested training to @training" do
        it{expect(assigns(:training)).to eq training}
      end
    end

    context "cannot load training" do
      before do
        allow(Education::Training).to receive(:find_by).and_return(nil)
        get :show, params: {id: training}
      end

      it "redirect to education_root_path" do
        expect(response).to redirect_to education_root_path
      end

      it "get a flash error" do
        expect(flash[:danger]).to eq I18n.t("education.trainings.show.not_found")
      end
    end
  end
end
