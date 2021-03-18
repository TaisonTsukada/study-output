require 'rails_helper'

RSpec.describe Stock, type: :model do
  before do
    create_user = FactoryBot.create(:user)
    article = FactoryBot.create(:article, user_id: create_user.id)
    another_user = FactoryBot.create(:user)
    @stock = Stock.new(user_id: another_user.id, article_id: article.id)
  end
  describe 'ストック機能' do
    context 'ストックできるとき' do
      it 'article_idとuser_idが正しく保存されれば、ストックできる' do
        expect(@stock).to be_valid
      end
    end
    context 'ストックができないとき' do
      it 'user_idが無いとストックできない' do
        @stock.user_id = ''
        @stock.valid?
        expect(@stock.errors.full_messages).to include('Userを入力してください')
      end
      it 'article_idが無いとストックできない' do
        @stock.article_id = ''
        @stock.valid?
        expect(@stock.errors.full_messages).to include('Articleを入力してください')
      end
    end
  end
end
