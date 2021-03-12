require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '投稿情報の保存' do
    before do
      user = FactoryBot.create(:user)
      @article = FactoryBot.build(:article, user_id: user.id)
    end
    context '投稿した記事の保存ができるとき' do
      it '全ての情報を正しく入力すれば保存される' do
        expect(@article).to be_valid
      end
    end
    context '投稿した記事が保存できないとき' do
      it 'titileが入力されていないと投稿できない' do
        @article.title = ""
        @article.valid?
        expect(@article.errors.full_messages). to include("タイトルを入力してください")
      end
      it 'titleが26文字以上だと投稿できない' do
        @article.title= "a"*26
        @article.valid?
        expect(@article.errors.full_messages).to include("タイトルは25文字以内で入力してください")
      end
      it 'タグ名が入力されていないと投稿できない' do
        @article.tag_list = []
        @article.valid?
        expect(@article.errors.full_messages).to include("タグを入力してください")
      end
      it  'タグ5個以上だと投稿できない' do
        @article.tag_list = ["世界史","数学","英語","国語", "化学", "物理"]
        @article.valid?
        expect(@article.errors.full_messages).to include("タグは５個までです")
      end
      it 'contentが入力されていないと投稿できない' do
        @article.content=nil
        @article.valid?
        expect(@article.errors.full_messages).to include("記事本文を入力してください")
      end
    end
  end
end
