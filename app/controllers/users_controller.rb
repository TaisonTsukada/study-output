class UsersController < ApplicationController
  before_action :set_user, only: [:show, :followings, :followers]
  before_action :authenticate_user!, only: [:update]

  def show
    @articles = @user.articles.order(created_at: :desc).page(params[:page]).per(9)
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
