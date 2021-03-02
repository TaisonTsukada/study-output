class LikesController < ApplicationController
  before_action :article_params
  before_action :authenticate_user!
  def create
    Like.create(user_id: current_user.id, article_id: params[:id])
    @article.create_notification_like!(current_user)
  end

  def destroy
    Like.find_by(user_id: current_user.id, article_id: params[:id]).destroy
  end

  private

  def article_params
    @article = Article.find(params[:id])
  end
end
