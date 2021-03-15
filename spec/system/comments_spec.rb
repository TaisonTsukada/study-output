require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @article = FactoryBot.create(:article)
    @comment = Faker::Lorem.sentence
  end
  it 'ログインしたユーザーはツイート詳細ページでコメント投稿できる' do
    # ログインする
    visit new_user_session_path
    fill_in 'Eメール', with: @article.user.email
    fill_in 'パスワード', with: @article.user.password
    click_button "Log in"
    expect(current_path).to eq(root_path)
    # ツイート詳細ページに遷移する
    visit article_path(@article.id)
    # フォームに情報を入力する
    fill_in 'comment_text', with: @comment
    # コメントを送信すると、コメント欄にコメントが含まれている
      click_button "コメントをする"
      expect(page).to have_content @comment
  end
end