class CommentsController < ApplicationController
  def index
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user_id = current_user.id
    render :index if @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    render :index if @comment.destroy
  end

  def comment_params
    params.require(:comment).permit(:text, :article_id, :user_id)
  end
end
