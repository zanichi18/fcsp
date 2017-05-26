require "rails_helper"

RSpec.describe UserPortfoliosController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  let!(:params_true) do
    FactoryGirl.attributes_for :user_portfolio,
      title: "portfolio1", description: "description"
  end
  let!(:params_fail){FactoryGirl.attributes_for :user_portfolio, title: nil}
  before do
    sign_in user
  end

  describe "DELETE #destroy" do
    let!(:user_portfolio){FactoryGirl.create :user_portfolio}
    it "responds successfully" do
      delete :destroy, params: {id: user_portfolio.id}, xhr: true
      expect{to change(UserPortfolio, :count).by(-1)}
    end
  end

  describe "PATCH #update" do
    let!(:user_portfolio){FactoryGirl.create :user_portfolio}
    context "with valid attributes" do
      it "update portfolio success" do
        patch :update, params: {id: user_portfolio,
          user_portfolio: {title: "title"}}, format: :js, xhr: true
        expect(assigns(:message))
          .to eq I18n.t("user_portfolios.update.success")
        expect(assigns(:status)).to eq 200
      end
    end

    context "with invalid attributes" do
      it "update fail" do
        patch :update, params: {id: user_portfolio,
          user_portfolio: {title: nil}}, format: :js, xhr: true
        expect(response).to have_http_status 200
      end
    end

    context "cannot load portfolio" do
      before do
        allow(User).to receive(:find_by).and_return(nil)
        get :update, params: {id: 100, status: 2}
      end

      it "redirect to user_path" do
        expect(response).to redirect_to user_path user
      end

      it "get a flash danger" do
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "POST #create" do
    it "create portfolio successfully" do
      post :create, params:
        {user_portfolio: FactoryGirl.attributes_for(:user_portfolio)},
          format: :js, xhr: true
      expect(assigns(:message))
        .to eq I18n.t("user_portfolios.create.success")
      expect(assigns(:status)).to eq 200
    end
  end
end
