require "rails_helper"

RSpec.describe UserLanguagesController, type: :controller do
  let!(:user){FactoryGirl.create :user}

  before :each do
    sign_in user
  end

  context "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new, xhr: true
      expect(response).to have_http_status 200
    end
  end

  describe "POST #create" do
    context "save success" do
      it "send a request" do
        expect do
          post :create, xhr: true, params: {
            user_language: {level: "native", language: "english"}
          }
        end.to change(UserLanguage, :count).by 1
      end
    end

    context "save failed" do
      it "can not save to database" do
        expect do
          post :create, xhr: true, params: {
            user_language: {level: "", language: "english"}
          }
        end.to change(UserLanguage, :count).by 0
      end
    end

    context "create language failed" do
      before do
        allow_any_instance_of(ActiveRecord::Relation)
          .to receive(:find_or_create_by).and_return false
      end
      it do
        expect do
          post :create, xhr: true, params: {
            user_language: {level: "", language: "english"}
          }
        end.to change(UserLanguage, :count).by 0
      end
    end
  end

  describe "PATCH #update" do
    let!(:language){FactoryGirl.create :language}
    let!(:user_language) do
      FactoryGirl.create(:user_language, level: "professional")
    end

    it "save success" do
      patch :update, xhr: true,
        params: {id: user_language.id,
          user_language: {language: language.name, level: "native"}}
      user_language.reload
      expect(user_language.level).to eq "native"
    end

    it "save failed" do
      patch :update, xhr: true,
        params: {id: user_language.id,
          user_language: {language: language.name, level: ""}}
      user_language.reload
      expect(user_language.level).to eq "professional"
    end
  end

  describe "GET #edit" do
    let!(:language){FactoryGirl.create :language}
    let!(:user_language) do
      FactoryGirl.create(:user_language, level: "professional")
    end

    context "load user_language success" do
      it "responds successfully with an HTTP 200 status code" do
        get :edit, xhr: true, params: {id: user_language.id}
        expect(response).to have_http_status 200
      end
    end

    context "load user_language failed" do
      it "responds successfully with an HTTP 200 status code" do
        get :edit, xhr: true, params: {id: ""}
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "DELETE #destroy" do
    context "destroy success" do
      let!(:language){FactoryGirl.create :language}
      let!(:user_language){FactoryGirl.create :user_language}
      it "send a request" do
        expect do
          delete :destroy, xhr: true, params: {id: user_language.id}
        end.to change(UserLanguage, :count).by -1
      end
    end

    context "destroy failed" do
      before do
        allow_any_instance_of(UserLanguage).to receive(:destroy)
          .and_return false
      end
      let!(:language){FactoryGirl.create :language}
      let!(:user_language){FactoryGirl.create :user_language}
      it "send a request" do
        expect do
          delete :destroy, xhr: true, params: {id: user_language.id}
        end.to change(UserLanguage, :count).by 0
      end
    end
  end
end
