require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end

  describe '#create,#destroy' do
    it 'ユーザーをフォロー、フォロー解除できる' do
      # @user1としてログイン
      visit new_user_session_path
      fill_in 'Eメール', with: @user1.email
      fill_in 'パスワード', with: @user1.password
      click_button 'Log in'
      expect(current_path).to eq(root_path)
      # @user1として@user2のマイページへ遷移する
      visit user_path(@user2)

      # @user2をフォローする
      find('.follow-btn').click
      visit user_path(@user2)
      expect(@user1.followings.count).to eq(1)
      expect(@user2.followers.count).to eq(1)

      # @user2をフォロー解除する
      click_button 'フォロー中'
      visit user_path(@user2)
      expect(@user1.followings.count).to eq(0)
      expect(@user2.followers.count).to eq(0)
    end
  end
end
