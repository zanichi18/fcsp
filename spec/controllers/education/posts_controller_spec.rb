RSpec.describe Education::PostsController, type: :controller do
  let(:post){FactoryGirl.create :education_post}

  describe "GET #index" do
    it do
      get :index
      expect(response).to have_http_status :success
    end
  end

  describe "GET #show" do
    before{get:show, params: {id: post}}

    context "load project success" do
      context "render show template" do
        it{expect(subject).to respond_with 200}
        it do
            expect(subject)
              .to render_with_layout "education/layouts/application"
        end
        it{expect(subject).to render_template :show}
      end

      context "assigns the requested post to @post" do
         it{expect(assigns(:post)).to eq post}
      end
    end

    context "load project failed" do
      before do
        allow(Education::Post).to receive(:find_by).and_return(nil)
        get :show, params: {id: post}
      end

      it "redirect to education_root_path" do
        expect(response).to redirect_to education_root_path
      end

      it "get a flash error" do
        expect(flash[:danger]).to eq(
          I18n.t("education.post.post_not_found"))
      end
    end
  end
end
