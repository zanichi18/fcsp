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
        expect(flash[:danger]).to eq(
          I18n.t("education.projects.project_not_found"))
      end
    end
  end

  describe "GET #new" do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "save new project to database" do
        expect{
          post :create, params:
            {education_project: FactoryGirl.attributes_for(:project)}
        }.to change(Education::Project, :count).by 1
      end

      it "redirects to project detail page" do
        post :create, params:
          {education_project: FactoryGirl.attributes_for(:project)}
        expect(response).to redirect_to(
          education_project_path(assigns[:project]))
      end
    end

    context "with invalid attributes" do
      it "does not save invalid project to database" do
        expect{
          post :create, params:
            {education_project: FactoryGirl.attributes_for(:invalid_project)}
        }.not_to change(Education::Project, :count)
      end

      it "re-renders :new template" do
        post :create, params:
          {education_project: FactoryGirl.attributes_for(:invalid_project)}
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    let(:project) {FactoryGirl.create :project, name: "Old Name",
      server_info: "Server info"}

    context "with valid attributes" do
      it "update project attributes" do
        patch :update, params: {id: project, education_project:
          FactoryGirl.attributes_for(:project, name: "New Name")}
        project.reload
        expect(project.name).to eq "New Name"
      end

      it "redirects to project detail page" do
        patch :update, params: {id: project, education_project:
          FactoryGirl.attributes_for(:project)}
        expect(response).to redirect_to project
      end
    end

    context "with invalid attributes" do
      it "does not update invalid project" do
        patch :update, params: {id: project, education_project:
          FactoryGirl.attributes_for(:project, name: "New Name",
            server_info: nil)}
        project.reload
        expect(project.name).not_to eq "New Name"
        expect(project.server_info).to eq "Server info"
      end

      it "re-renders :edit template" do
        patch :update, params: {id: project,
          education_project: FactoryGirl.attributes_for(:invalid_project)}
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:project) {FactoryGirl.create :project}
    it "deletes the project" do
      expect{
        delete :destroy, params: {id: project}
      }.to change(Education::Project, :count).by -1
    end

    it "redirects to education root path" do
      delete :destroy, params: {id: project}
      expect(response).to redirect_to education_root_path
    end
  end
end
