require "rails_helper"

RSpec.describe Education::CommentPostsController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  let!(:user2){FactoryGirl.create :user}
  let!(:education_post){FactoryGirl.create :education_post}
  let!(:comment){FactoryGirl.create :comment, user_id: user.id, commentable_id: education_post.id, content: "ABC"}
  let!(:comment2){FactoryGirl.create :comment, user_id: user2.id, commentable_id: education_post.id, content: "ABC"}
  
  before :each do
    allow(controller).to receive(:current_user).and_return(user)
    sign_in user
  end

  describe "POST #create" do
    it "expect comment successful save" do
      expect do
        xhr :post, :create,
          params: {post_id: education_post.id, education_comment: {user_id: user.id, content: "abc"}} end
          .to change(Education::Comment, :count).by(1)
          expect(assigns[:comment]).to be_an_instance_of Education::Comment
    end
  end

  it "content comment empty" do
    expect do
      xhr :post, :create,
        params: {post_id: education_post.id, education_comment: {user_id: user.id, content: ""}} end
        .to change(Education::Comment, :count).by(0)
        expect(assigns[:comment]).to be_an_instance_of Education::Comment
  end

  describe "DELETE #destroy" do
    it "delete a comment successfully" do
      expect do
          xhr :delete , :destroy, params: {id: comment.id, post_id: education_post.id} end
            .to change(Education::Comment, :count).by(-1)
    end

    it "delete a comment unsuccessfully" do
      expect do
          xhr :delete, :destroy, params: {id: comment2.id, post_id: education_post.id} end
            .to change(Education::Comment, :count).by(0)
    end
  end

  describe "GET #edit" do
    it do
      xhr :get, :edit, params: {id: comment.id, post_id: education_post.id}
      expect(response).to render_template :edit
    end
  end

  describe "PUT #update" do
    it "action comment update state success" do
      xhr :put, :update, params: {id: comment.id, post_id: education_post.id, education_comment: {content: "CAD"}}
      expect((Education::Comment.find(comment.id)).content).to eq "CAD"
    end

    it "action comment update state fail" do
      xhr :put, :update, params: {id: comment.id, post_id: education_post.id, education_comment: {content: ""}}
      expect((Education::Comment.find(comment.id)).content).to eq "ABC"
    end
  end
end
