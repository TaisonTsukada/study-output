class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to article_path(@comment.article)
    else
      @article = @comment.article
      @comment = @article.comments
      render "articles/show"
    end
  end


  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, article_id: params[:article_id])
  end
end
