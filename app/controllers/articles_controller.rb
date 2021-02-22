class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :set_article, only: [:show, :destroy, :edit, :update]
  before_action :move_to_index, only: [:edit, :update]
  
  def index
    @article = Article.all.order(created_at: :desc)
    @tags = Article.tag_counts_on(:tags).most_used(20)
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
    @comment = Comment.new
    @comments = @article.comments.includes(:user)
  end

  def destroy
    if current_user.id == @article.user.id
      @article.destroy
      redirect_to root_path
    end
  end

  def edit
    
  end

  def update
    if @article.update(article_params)
      redirect_to article_path
    else
      render :edit
    end
  end

  def search
    return nil if params[:keyword] == ''

    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"])
    render json: { keyword: tag }
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :tag_list).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def move_to_index
    set_article
    unless current_user.id == @article.user.id
      redirect_to root_path
    end
  end
end
