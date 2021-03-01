class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :set_article, only: [:show, :destroy, :edit, :update]
  before_action :move_to_index, only: [:edit, :update]
  before_action :set_q, only: [:index, :articles_search]

  def index
    @articles = Article.all.order(created_at: :desc).page(params[:page]).per(9)
    @tags = Article.tag_counts_on(:tags).order('count DESC')
    if @tag = params[:tag]
      @articles = Article.tagged_with(params[:tag]).page(params[:page]).per(9)
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @comment = Comment.new
    @comments = @article.comments
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

  def articles_search
    @results = @q.result
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :tag_list, :image).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def move_to_index
    set_article
    redirect_to root_path unless current_user.id == @article.user.id
  end

  def set_q
    @q = Article.ransack(params[:q])
  end
end
