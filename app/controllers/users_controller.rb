class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :followings, :followers]
  before_action :authenticate_user!
  before_action :move_to_index, only: [:edit]

  def show
  end

  def edit
  end

  def update
    current_user.update(update_params)
  end

  def followings
    @users = @user.followings.all
  end

  def followers
    @users = @user.followers.all
  end

  private

  def update_params
    params.require(:user).permit(:image)
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
