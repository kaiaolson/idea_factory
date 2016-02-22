class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def index
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: "Sign up successful!"
    else
      render :new
    end
  end

  def update
    if @user.update user_params
      redirect_to user_path(@user), notice: "Profile updated successfully."
    else
      render :edit, notice:  "Profile not updated."
    end
  end

  private
    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
