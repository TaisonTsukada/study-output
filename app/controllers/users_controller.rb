class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show]
  
  def show
  end

  def edit
  end

  def update
    current_user.update(update_params)
  end

  private
  def update_params
    params.require(:user).permit(:image)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
