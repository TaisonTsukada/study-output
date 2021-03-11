class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :set_article, only: [:show, :destroy, :edit, :update]
  before_action :move_to_index, only: [:edit, :update]

  def index
    @tags = Article.tag_counts_on(:tags).order('count DESC')
    if params[:option] == 'views'
      @articles = Article.includes(:user, :likes, :tags).order(impressions_count: 'DESC').page(params[:page]).per(9)
    elsif params[:option] == 'likes'
      article_like_count = Article.joins(:likes).group(:article_id).count
      article_liked_ids = Hash[article_like_count.sort_by { |_, v| -v }].keys
      @articles = Article.includes(:user, :likes,
                                   :tags).where(id: article_liked_ids).order(created_at: :desc).page(params[:page]).per(9)
    elsif params[:id] == 'timeline'
      @articles = Article.where(user_id: [*current_user.following_ids]).order(created_at: :desc).page(params[:page]).per(9)
    elsif @q_header
      @articles = @q_header.result(distinct: true).page(params[:page]).per(9)
    else
      @articles = Article.includes(:user, :likes, :tags).order(created_at: :desc).page(params[:page]).per(9)
    end

    @articles = Article.tagged_with(params[:tag]).includes(:user, :likes).page(params[:page]).per(9) if @tag = params[:tag]
  end

  def new
    @article = Article.new
  end

  def create
    binding.pry
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
    impressionist(@article, nil, unique: [:ip_address])
    tag_list = @article.tag_list
    @articles = Article.tagged_with(tag_list).where.not(id: @article.id).limit(5)
    @articles = Article.order('RAND()').where.not(id: @article.id).limit(5) if @articles.blank?
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
end
