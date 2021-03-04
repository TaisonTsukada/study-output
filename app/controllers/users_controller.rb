class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :followings, :followers]
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :move_to_index, only: [:edit]

  def show
    @articles = @user.articles.order(created_at: :desc).page(params[:page]).per(9)
  end

  def edit
  end

  def update
    if current_user.update(update_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  def followings
    @users = @user.followings.all
  end

  def followers
    @users = @user.followers.all
  end

  private

  def update_params
    params.require(:user).permit(:image, :nickname, :email, :password, :password_confirmation )
  end

  def set_user
    @user = User.find(params[:id])
  end

  def move_to_index
    set_user
    unless current_user.id == @user.id
    end
  end
end
