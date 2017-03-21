require "rails_helper"

RSpec.describe Education::CoursesController, type: :controller do
  describe "GET #index" do

    it do
      get :index
      expect(response).to have_http_status :success
    end
    it "load courses success" do
      training = FactoryGirl.create :training
      course = FactoryGirl.create :course
      courses = Education::Course.newest
      expect([course]).to match_array(courses)
    end

     it "load courses fail" do
      courses = Education::Course.newest
      expect([]).to match_array(courses)
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
      it "save new course to database" do
        expect{
          post :create, params:
            {education_course: FactoryGirl.attributes_for(:course)}
        }.to change(Education::Course, :count).by 1
      end

      it "redirects to index courses page" do
        post :create, params:
          {education_course: FactoryGirl.attributes_for(:course)}
        expect(response).to redirect_to education_courses_path
      end
    end

    context "with invalid attributes" do
      it "does not save invalid project to database" do
        expect{
          post :create, params:
            {education_course: FactoryGirl.attributes_for(:invalid_course)}
        }.not_to change(Education::Course, :count)
      end

      it "re-renders :new template" do
        post :create, params:
          {education_course: FactoryGirl.attributes_for(:invalid_course)}
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    let(:course){FactoryGirl.create :course, name: "Course 1",
      detail: "Course Old"}

    context "with valid attributes" do
      it "update course attributes" do
        patch :update, params: {id: course, education_course:
          FactoryGirl.attributes_for(:course, name: "Course")}
        course.reload
        expect(course.name).to eq "Course"
      end

      it "redirects to index courses page" do
        patch :update, params: {id: course, education_course:
          FactoryGirl.attributes_for(:course)}
        expect(response).to redirect_to education_courses_path
      end
    end

    context "with invalid attributes" do
      it "does not update invalid eattributes" do
        patch :update, params: {id: course, education_course:
          FactoryGirl.attributes_for(:course, name: "Course",
            detail: nil)}
        course.reload
        expect(course.name).not_to eq "Course"
        expect(course.detail).to eq "Course Old"
      end

      it "re-renders :edit template" do
        patch :update, params: {id: course,
          education_course: FactoryGirl.attributes_for(:invalid_course)}
        expect(response).to render_template :edit
      end
    end
  end
  
  describe "DELETE #destroy" do
    let!(:course){FactoryGirl.create :course}
    it "deletes the course" do
      expect{
        delete :destroy, params: {id: course}
      }.to change(Education::Course, :count).by -1
    end

    it "redirects to index courses page" do
      delete :destroy, params: {id: course}
      expect(response).to redirect_to education_courses_path
      end
  end

  context "cannot load course" do
    let!(:course){FactoryGirl.create :course}
    before do
      allow(Education::Course).to receive(:find_by).and_return(nil)
      get :edit, params: {id: course}
    end

    it "redirect to education_root_path" do
      expect(response).to redirect_to education_courses_path
    end

    it "get a flash error" do
      expect(flash[:danger]).to eq I18n.t("education.courses.not_found")
    end
  end
end
