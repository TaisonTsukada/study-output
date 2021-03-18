require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    followed_user = FactoryBot.create(:user)
    follower_user = FactoryBot.create(:user)
    @relationship = Relationship.new(user_id: followed_user.id, follow_id: follower_user.id)
    sleep(1)
  end
  describe 'フォロー機能' do
    context 'フォローできるとき' do
      it 'user_idとfollow_idがあればフォローできる' do
        expect(@relationship).to be_valid
      end
    end
    context 'フォローができないとき' do
      it 'user_idが無いとフォローできない' do
        @relationship.user_id = ''
        @relationship.valid?
        expect(@relationship.errors.full_messages).to include('Userを入力してください')
      end
      it 'article_idが無いとフォローできない' do
        @relationship.follow_id = nil
        @relationship.valid?
        expect(@relationship.errors.full_messages).to include('Followを入力してください')
      end
    end
  end
end
