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
end
