class StocksController < ApplicationController
  def index
    
  end

  def create
    @article = Article.find(params[:article_id])
    # 取得した記事がまだストックされていなければ
    unless @article.stocked?(current_user)
      # ログインしているユーザーを取得してparamsで渡された記事をストック
      @article.stock(current_user)
      # ajaxでストックボタンを実装
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @article = Stock.find(params[:id]).article
    # 取得した記事が既にストックされていれば
    if @article.stocked?(current_user)
      # ログインしているユーザーを取得してparamsで渡された記事のストック解除
      @article.unstock(current_user)
      # ajaxでストックボタンを実装
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end
