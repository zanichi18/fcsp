require "rails_helper"

RSpec.describe Education::CommentsController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  let!(:project){FactoryGirl.create :project}
  describe "POST #create" do
     it "expect comment successful save" do
       expect do
         xhr :post , :create,
           params: {project_id: project.id, education_comment: {user_id: user.id, content: "abc"}} end
           .to change(Education::Comment, :count).by(1)
           expect(assigns[:comment]).to be_an_instance_of Education::Comment
     end
   end

   it "content comment empty" do
     expect do
       xhr :post , :create,
         params: {project_id: project.id, education_comment: {user_id: user.id, content: ""}} end
         .to change(Education::Comment, :count).by(0)
         expect(assigns[:comment]).to be_an_instance_of Education::Comment
    end
  describe "DELETE #destroy" do
    let!(:comment){FactoryGirl.create :comment, user_id: user.id, commentable_id: project.id, content: "ABC"}
    it "delete a comment successfully" do
      expect do
           xhr :delete , :destroy, params: {id: comment.id, project_id: project.id} end
            .to change(Education::Comment, :count).by(-1)
    end

    it "delete a comment successfully" do
      allow_any_instance_of(Education::Comment).to receive(:destroy).and_return(false)
      expect do
           xhr :delete , :destroy, params: {id: comment.id, project_id: project.id} end
            .to change(Education::Comment, :count).by(0)
    end
  end

  describe "GET #edit" do
  let!(:comment){FactoryGirl.create :comment, user_id: user.id, commentable_id: project.id, content: "ABC"}
   it do
      xhr :get, :edit, params: {id: comment.id, project_id: project.id}
      expect(response).to render_template :edit
    end
  end

  describe "PUT #update" do
  let!(:comment){FactoryGirl.create :comment, user_id: user.id, commentable_id: project.id, content: "ABC"}
   it "action comment update state success" do
      xhr :put, :update, params: {id: comment.id, project_id: project.id, education_comment: {content: "CAD"}}
      expect((Education::Comment.find(comment.id)).content).to eq "CAD"
    end
   it "action comment update state fail" do
      xhr :put, :update, params: {id: comment.id, project_id: project.id, education_comment: {content: ""}}
      expect((Education::Comment.find(comment.id)).content).to eq "ABC"
    end
  end
end
