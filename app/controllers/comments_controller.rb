class CommentsController < ApplicationController
  before_action :find_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update]

  def new
    @comment = Comment.new
  end

  def create
    @idea = Idea.find params[:idea_id]
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.new comment_params
    @comment.idea = @idea
    @comment.user = current_user
    if @comment.save
      redirect_to idea_path(@idea), notice: "Comment created!"
    else
      render "/ideas/show", alert: "Comment not created!"
    end
  end

  def show
  end

  def index
    @comments = Comment.page params[:page]
  end

  def edit
  end

  def update
    idea = @comment.idea
    if @comment.update comment_params
      redirect_to idea_path(idea)
    else
      render :edit
    end
  end

  def destroy
    if can? :destroy, @comment
      @comment.destroy
      redirect_to idea_path(params[:idea_id]), notice: "Comment deleted!"
    else
      raise CanCan::AccessDenied.new("Not authorized!", :destroy, Comment)
      redirect_to idea_path(params[:idea_id])
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :idea_id, :user_id)
  end

  def find_comment
    @comment = Comment.find params[:id]
  end

  def authorize_user
    unless can? :manage, @comment
      redirect_to root_path, alert: "access denied!"
    end
  end

end
