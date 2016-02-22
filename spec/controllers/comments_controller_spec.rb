require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user)      { FactoryGirl.create(:user) }
  let(:user_1)    { FactoryGirl.create(:user) }
  let(:idea)      { FactoryGirl.create(:idea, {user: user}) }
  let(:comment)   { FactoryGirl.create(:comment, {idea: idea, user: user}) }
  let(:comment_1) { FactoryGirl.create(:comment, {user: user_1}) }
  let(:comment_2) { FactoryGirl.create(:comment, {idea: idea, user: user_1}) }

  describe "#create" do
    context "user signed in" do
      before { login(user) }

      context "with valid request" do
        def valid_request
          post :create, idea_id: idea.id,
                        comment: FactoryGirl.attributes_for(:comment)
        end
        it "creates a record in the database" do
          count_before = Comment.count
          valid_request
          count_after = Comment.count
          expect(count_after - count_before).to eq(1)
        end
        it "redirects to the idea show page" do
          valid_request
          expect(response).to redirect_to(idea_path(idea))
        end
        it "associates the comment with the current user" do
          valid_request
          expect(Comment.last.user).to eq(user)
        end
      end
    end

    context "user not signed in" do
      it "redirects to the login page" do
        post :create, idea_id: idea.id,
                      comment: FactoryGirl.attributes_for(:comment)
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe "#destroy" do
    context "user signed in" do
      before { login(user) }

      context "current user owns the comment" do
        it "destroys the comment" do
          comment
          count_before = Comment.count
          delete :destroy, idea_id: idea.id, id: comment.id
          count_after = Comment.count
          expect(count_before - count_after).to eq(1)
        end
        it "redirects to the idea show page" do
          delete :destroy, idea_id: idea.id, id: comment.id
          expect(response).to redirect_to(idea_path(idea))
        end
      end

      context "current user does not own the comment" do
        it "raises an error" do
          expect do
            delete :destroy, idea_id: comment_1.idea.id, id: comment_1.id
          end.to raise_error(CanCan::AccessDenied)
        end
      end

      context "current user owns the idea but not the comment" do
        it "deletes the comment" do
          count_before = Comment.count
          delete :destroy, idea_id: idea.id, id: comment_2.id
          count_after = Comment.count
          expect(count_before - count_after).to eq(1)
        end
        it "redirects back to the idea show page" do
          delete :destroy, idea_id: idea.id, id: comment_2.id
          expect(response).to redirect_to(idea_path(idea))
        end
      end
    end

    context "user not signed in" do
      it "redirects to the login page" do
        delete :destroy, idea_id: idea.id, id: comment.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

end
