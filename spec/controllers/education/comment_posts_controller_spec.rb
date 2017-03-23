require "rails_helper"

RSpec.describe Education::CommentPostsController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  let!(:education_post){FactoryGirl.create :education_post}

  describe "POST #create" do
     it "expect comment successful save" do
       expect do
         xhr :post , :create,
           params: {post_id: education_post.id, education_comment: {user_id: user.id, content: "abc"}} end
           .to change(Education::Comment, :count).by(1)
           expect(assigns[:comment]).to be_an_instance_of Education::Comment
     end
   end

   it "content comment empty" do
     expect do
       xhr :post , :create,
         params: {post_id: education_post.id, education_comment: {user_id: user.id, content: ""}} end
         .to change(Education::Comment, :count).by(0)
         expect(assigns[:comment]).to be_an_instance_of Education::Comment
    end
  describe "DELETE #destroy" do
    let!(:comment){FactoryGirl.create :comment, user_id: user.id, commentable_id: education_post.id, content: "ABC"}
    it "delete a comment successfully" do
      expect do
           xhr :delete , :destroy, params: {id: comment.id, post_id: education_post.id} end
            .to change(Education::Comment, :count).by(-1)
    end

    it "delete a comment successfully" do
      allow_any_instance_of(Education::Comment).to receive(:destroy).and_return(false)
      expect do
           xhr :delete , :destroy, params: {id: comment.id, post_id: education_post.id} end
            .to change(Education::Comment, :count).by(0)
    end
  end

  describe "GET #edit" do
  let!(:comment){FactoryGirl.create :comment, user_id: user.id, commentable_id: education_post.id, content: "ABC"}
   it do
      xhr :get, :edit, params: {id: comment.id, post_id: education_post.id}
      expect(response).to render_template :edit
    end
  end

  describe "PUT #update" do
  let!(:comment){FactoryGirl.create :comment, user_id: user.id, commentable_id: education_post.id, content: "ABC"}
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
