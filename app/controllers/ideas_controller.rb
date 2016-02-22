class IdeasController < ApplicationController
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @ideas = Idea.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @idea = Idea.new
  end

  def edit
  end

  def create
    @idea = Idea.new idea_params
    @idea.user = current_user
    if @idea.save
      redirect_to idea_path(@idea)
      flash[:notice] = "Idea created!"
    else
      render :new
      flash[:alert] = "Idea not created!"
    end
  end

  def update
    if @idea.update idea_params
      redirect_to idea_path(@idea)
      flash[:notice] = "Idea updated!"
    else
      render :edit
      flash[:alert] = "Idea not updated!"
    end
  end

  def destroy
    @idea.destroy
    redirect_to ideas_path
    flash[:notice] = "Your idea was deleted!"
  end

  private

  def find_idea
    @idea = Idea.find(params[:id])
  end

  def idea_params
    params.require(:idea).permit(:title, :description, :image)
  end

  def authorize_user
    unless can? :manage, @idea
      redirect_to root_path, alert: "access denied!"
    end
  end
end
