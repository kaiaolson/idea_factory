class MembershipsController < ApplicationController
  before_action :authenticate_user

  def create
    idea = Idea.find(params[:idea_id])
    membership = Membership.new(idea: idea, user: current_user)
    if membership.save
      redirect_to ideas_path, notice: "You're now a member of #{idea.title}!"
    else
      redirect_to ideas_path, alert: "Unable to join #{idea.title}!"
    end
  end

  def destroy
    membership = current_user.memberships.find params[:id]
    membership.destroy
    redirect_to ideas_path, notice: "You have removed your membership!"
  end

end
