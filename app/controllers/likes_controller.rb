class LikesController < ApplicationController
  def create
    Like.create(user_id: current_user.id, article_id: params[:id])
    redirect_to article_path(article_id)
  end
end
