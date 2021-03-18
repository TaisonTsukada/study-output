class UsersController < ApplicationController
  before_action :set_user, only: [:show, :followings, :followers]
  before_action :authenticate_user!, only: [:update]

  def show
    if params[:option] == 'stocks'
      stock_articles = Stock.get_stock_articles(current_user)
      @articles = Kaminari.paginate_array(stock_articles).page(params[:page]).per(9)
    elsif params[:option] == 'likes'
      likes_articles = Like.get_likes_articles(current_user)
      @articles = Kaminari.paginate_array(likes_articles).page(params[:page]).per(9)
    else
      @articles = @user.articles.order(created_at: :desc).page(params[:page]).per(9)
    end

    if user_signed_in?
      @currentUserEntry = Entry.where(user_id: current_user.id)
      @userEntry = Entry.where(user_id: @user.id)
      unless @user.id == current_user.id
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end
        unless @isRoom
          @room = Room.new
          @entry = Entry.new
        end
      end
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
    params.require(:user).permit(:image, :nickname, :email, :password, :password_confirmation)
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
