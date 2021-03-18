require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#create' do
    before do
      user = FactoryBot.create(:user)
      article = FactoryBot.create(:article, user_id: user.id)
      @comment_user = FactoryBot.create(:user)
      @comment = Comment.new(user_id: @comment_user.id, article_id: article.id, text: 'とてもいい記事です')
      sleep(1)
    end
    it '正しく文章を入力すればコメントできること' do
      expect(@comment).to be_valid
    end
    it '文章が空だとコメントできないこと' do
      @comment.text = ''
      @comment.valid?
      expect(@comment.errors.full_messages).to include('Textを入力してください')
    end
    it 'user_idが空だとコメントできない' do
      @comment.user_id = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include('Userを入力してください')
    end
    it 'article_idが空だとコメントできない' do
      @comment.article_id = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include('Articleを入力してください')
    end
  end
end
