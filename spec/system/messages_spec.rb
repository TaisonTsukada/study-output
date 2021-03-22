require 'rails_helper'

RSpec.describe 'メッセージ投稿機能', type: :system do
  before do
    # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
    @entry1 = FactoryBot.create(:entry, room_id: @room.id, user_id: @user1.id)
    @entry2 = FactoryBot.create(:entry, room_id: @room.id, user_id: @user2.id)
    sleep(1)
  end

  context '投稿に失敗したとき' do
    it '送る値が空の為、メッセージの送信に失敗すること' do
      # サインインする
      sign_in(@user1)
      # 作成されたチャットルームへ遷移する
      visit room_path(@room.id)
      # DBに保存されていないことを確認する
      expect do
        find('.msg_send_btn').click
      end.not_to change {Message.count}
      # 元のページに戻ってくることを確認する
      expect(current_path).to eq(room_path(@room.id))

    end
  end
  context '投稿に成功したとき' do
    it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
      # サインインする
      sign_in(@user1)
      # 作成されたチャットルームへ遷移する
      visit room_path(@room.id)
      # 値をテキストフォームに入力する
      post = 'テスト'
      fill_in 'message_message', with: post
      # 送信した値がDBに保存されていることを確認する
      expect {
        find('.msg_send_btn').click
        visit room_path(@room.id)
      }.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq(room_path(@room))

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)

    end

  end
end
