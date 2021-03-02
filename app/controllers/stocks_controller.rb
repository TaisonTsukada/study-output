class StocksController < ApplicationController
  def index
    stock_articles = Stock.get_stock_articles(current_user)
    @stock_articles = Kaminari.paginate_array(stock_articles).page(params[:page]).per(9)
  end

  def create
    @article = Article.find(params[:article_id])
    unless @article.stocked?(current_user)
      @article.stock(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @article = Stock.find(params[:id]).article
    if @article.stocked?(current_user)
      @article.unstock(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end
