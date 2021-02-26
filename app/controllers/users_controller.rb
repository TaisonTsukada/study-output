class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    #ユーザーの投稿一覧
    @articles = @user.article.all.order(created_at: :desc).page(params[:page]).per(9)
  end
end
