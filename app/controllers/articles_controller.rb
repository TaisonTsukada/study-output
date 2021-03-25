class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :set_article, only: [:show, :destroy, :edit, :update]
  before_action :move_to_index, only: [:edit, :update]

  def index
    @tags = Article.tag_counts_on(:tags).order('count DESC').limit(15)
    if params[:option] == 'views'
      @articles = Article.includes(:user, :likes, :tags).order(impressions_count: 'DESC').page(params[:page]).per(9)
    elsif params[:option] == 'likes'
      articles_array= Article.includes(:liked_users, :user, :tags).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
      @articles = Kaminari.paginate_array(articles_array).page(params[:page]).per(9)
    elsif params[:option] == 'timeline'
      @articles = Article.where(user_id: [*current_user.following_ids]).order(created_at: :desc).page(params[:page]).per(9)
    elsif @q_header
      @articles = @q_header.result(distinct: true).order(created_at: :desc).page(params[:page]).per(9)
    else
      @articles = Article.includes(:user, :likes, :tags).order(created_at: :desc).page(params[:page]).per(9)
    end
    if @tag = params[:tag]
      @articles = Article.tagged_with(params[:tag]).includes(:user,
                                                             :likes).order(created_at: :desc).page(params[:page]).per(9)
    end

    @notifications = current_user.passive_notifications.page(params[:page]).per(5) if user_signed_in?
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to root_path, notice: '投稿が完了しました'
    else
      flash.now[:alert] = '投稿内容を正しく入力してください'
      render 'new'
    end
  end

  def show
    @comment = Comment.new
    @comments = @article.comments
    impressionist(@article, nil, unique: [:ip_address])
    tag_list = @article.tag_list
    @articles = Article.tagged_with(tag_list).where.not(id: @article.id).limit(3)
    @articles = Article.order('RAND()').where.not(id: @article.id).limit(3) if @articles.blank?
  end

  def destroy
    if current_user.id == @article.user.id
      @article.destroy
      redirect_to root_path, notice: '投稿を削除しました'
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to article_path, notice: '投稿を編集をしました'
    else
      flash.now[:alert] = '投稿内容を正しく入力してください'
      render :edit
    end
  end

  def tag_list
    @tags = Article.tag_counts_on(:tags).order('count DESC').page(params[:page]).per(18)
    return unless request.xhr?

    case params[:type]
    when 'tags'
      render "articles/#{params[:type]}"
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :tag_list, :image, :youtube_url).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def move_to_index
    set_article
    redirect_to root_path unless current_user.id == @article.user.id
  end
end
