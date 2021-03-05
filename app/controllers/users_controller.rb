class UsersController < ApplicationController
  before_action :set_user, only: [:show, :followings, :followers]
  before_action :authenticate_user!, only: [:update]

  def show
    if params[:option] == "stocks"
      stock_articles = Stock.get_stock_articles(current_user)
      @articles = Kaminari.paginate_array(stock_articles).page(params[:page]).per(9)
    elsif params[:option] == "likes"
      @articles =[]
      articles_id = Like.where(user_id: current_user.id).map{ |h| h[:article_id] }
      articles_id.each do |article_id|
        @articles = Article.find_by(id: article_id)
      end
      @articles.to_s
    else
      @articles = @user.articles.order(created_at: :desc).page(params[:page]).per(9)
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
