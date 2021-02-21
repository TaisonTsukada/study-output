require 'rails_helper'

RSpec.describe ArticlesTag, type: :model do
  describe '投稿情報の保存' do
    before do
      user = FactoryBot.create(:user)
      @articles_tag = FactoryBot.build(:articles_tag, user_id: user.id)
    end

    context '投稿した記事の保存ができるとき' do
      it '全ての情報を正しく入力すれば保存される' do
        expect(@articles_tag).to be_valid
      end
    end
    context '投稿した記事が保存できないとき' do
      it 'titileが入力されていないと投稿できない' do
        
      end
      it 'titleが20文字以上だと投稿できない' do
        
      end
      it 'タグ名が入力されていないと投稿できない' do
        
      end
      it 'contentが入力されていないと投稿できない' do
        
      end
      it 'contentが500文字以上だと投稿できない' do
        
      end
    end
  end
end
