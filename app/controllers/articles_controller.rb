class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @article = Article.all.order(created_at: :desc)
  end

  def new
    @article = ArticlesTag.new
  end

  def create
    @article = ArticlesTag.new(article_params)
    if @article.valid?
      @article.save
      return redirect_to root_path
    else
      render :new
    end
  end

  private
  def article_params
    params.require(:articles_tag).permit(:title, :content, :name).merge(user_id: current_user.id)
  end
end
