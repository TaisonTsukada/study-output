require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '投稿情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @article_tag = ArticlesTag.new(title: '世界史', content: 'テスト本文', name: '世界史', user_id: @user.id)
    end

    context '投稿した記事の保存ができるとき' do
      it '全ての情報を正しく入力すれば保存される' do
        expect(@article_tag).to be_valid
      end
    end
    context '投稿した記事が保存できないとき' do
      it 'titileが入力されていないと投稿できない' do
        @article_tag.title = ''
        @article_tag.valid?
        expect(@article_tag.errors.full_messages).to include("Title can't be blank")
      end
      it 'titleが20文字以上だと投稿できない' do
        @article_tag.title = 'aiueoaiueoaiueoaiueoa'
        @article_tag.valid?
        expect(@article_tag.errors.full_messages).to include('Title is too long (maximum is 20 characters)')
      end
      it 'タグ名が入力されていないと投稿できない' do
        @article_tag.name = ''
        @article_tag.valid?
        expect(@article_tag.errors.full_messages).to include("Name can't be blank")
      end
      it 'contentが入力されていないと投稿できない' do
        article_tag = ArticlesTag.new(title: 'test', content: '', name: 'テスト', user_id: @user.id)
        article_tag.valid?
        expect(article_tag.errors.full_messages).to include("Content can't be blank")
      end
      it 'contentが500文字以上だと投稿できない' do
        article_tag = ArticlesTag.new(title: 'test', content: 'a' * 501, name: 'テスト', user_id: @user.id)
        article_tag.valid?
        expect(article_tag.errors.full_messages).to include('Content is too long (maximum is 500 characters)')
      end
    end
  end
end
