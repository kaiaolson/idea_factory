class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    idea = Idea.find params[:idea_id]
    like = Like.new(idea: idea, user: current_user)
    if like.save
      LikesMailer.notify_idea_owner(like).deliver_later
      redirect_to ideas_path, notice: "Liked!"
    else
      redirect_to ideas_path, alert: "Not Liked!"
    end
  end

  def destroy
    like = current_user.likes.find params[:id]
    like.destroy
    redirect_to ideas_path, notice: "Unliked!"
  end
end
