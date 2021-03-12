require 'rails_helper'
describe ArticlesController, type: :request do

  before do
    @article = FactoryBot.create(:article)
    
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みの記事のタイトルが存在する' do 
      get root_path
      expect(response.body).to include(@article.title)
    end
    it 'indexアクションにリクエストするとレスポンスに記事を投稿したユーザーの名前が存在する' do
      get root_path
      expect(response.body).to include(@article.user.nickname)
    end
    it 'indexアクションにリクエストするとレスポンスに記事に投稿済みのタグが存在する' do 
      get root_path 
      tag_name = ""
      @article.tags.each do |tag|
        tag_name = tag.name
      end
      expect(response.body).to include(tag_name)
    end
    it 'indexアクションにリクエストするとレスポンスに記事のいいね数が表示される' do
      get root_path
      expect(response.body).to include("#{@article.likes.count}")
    end
    it 'indexアクションにリクエストするとレスポンスに記事が投稿された時間が存在する' do
      get root_path
      expect(response.body).to include("前")
    end
    it 'indexアクションにリクエストするとレスポンスにナブメニューが存在し、「いいねの多い記事」が存在する' do
      get root_path
      expect(response.body).to include("いいねの多い記事")
    end
    it 'indexアクションにリクエストするとレスポンスにナブメニューが存在し、「閲覧数の多い記事」が存在する' do
      get root_path
      expect(response.body).to include("閲覧数の多い記事") 
    end
    it 'indexアクションにリクエストするとレスポンスにナブメニューが存在し、「タイムライン」が存在する' do
      get root_path
      expect(response.body).to include("タイムライン")
    end
    it 'indexアクションにリクエストするとサイドバーに人気タグの一覧が表示されている' do
      get root_path
      expect(response.body).to include("人気タグ")
    end
  end
  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get article_path(@article)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの記事のタイトルが存在する' do 
      get article_path(@article)
      expect(response.body).to include(@article.title)
    end
    it 'showアクションにリクエストすると投稿済みの記事の投稿者表示される' do
      get article_path(@article)
      expect(response.body).to include(@article.user.nickname)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みの記事の記事本文が存在する' do 
      get article_path(@article)
      expect(response.body).to include()
    end
    it 'showアクションにリクエストするとレスポンスにコメント一覧表示部分が存在する' do 
      get article_path(@article)
      expect(response.body).to include("コメント")
    end
  end 
end
