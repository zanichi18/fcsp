require "rails_helper"

RSpec.describe CompaniesAvatarsController, type: :controller do
  let!(:company){FactoryGirl.create :company}
  let!(:image) do
    Rack::Test::UploadedFile
      .new(Rails.root.join("spec", "support", "education", "image", "test.jpg"))
  end

  describe "POST #create" do
    it "change avatar successfully" do
      post :create, params: {id: company.id, picture: image}
      expect(controller).to set_flash[:success]
        .to(I18n.t "companies.avatar.success")
    end

    it "change avatar fail" do
      post :create, params: {id: company.id, picture: "file.jpg"}
      expect(controller).to set_flash[:danger]
        .to(I18n.t "companies.avatar.danger")
    end
  end

  describe "PATCH #update" do
    it "update avatar successfully" do
      avatar = Image.create imageable: company, picture: image
      patch :update, params: {id: company.id, image_id: avatar.id}
      expect(controller).to set_flash[:success]
        .to(I18n.t "companies.avatar.success")
    end
  end
end
