class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_article, only: [:show, :destroy]
  def index
    @article = Article.all.order(created_at: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
       redirect_to root_path
    else
      render "new"
    end
  end

  def show
  end

  def destroy
    if current_user.id == @article.user.id
      @article.destroy
      redirect_to root_path
    end
  end

  def search
    return nil if params[:keyword] == ''

    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"])
    render json: { keyword: tag }
  end

  private

  def article_params
    params.require(:articles_tag).permit(:title, :content, :tag_list).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
