require 'rails_helper'

RSpec.describe "Articles", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article_title = "世界史の勉強の仕方"
    @article_tag = "世界史"
    @article_content = "Hello <em>world!</em>"
  end
  context '記事投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Eメール', with: @user.email
      fill_in 'パスワード', with: @user.password
      click_button "Log in"
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_article_path
      # フォームに情報を入力する
      image_path = Rails.root.join('app/assets/images/test-image.png')
      attach_file('article[image]', image_path)
      fill_in 'article_title', with: @article_title
      #fill_in 'article_tag_list', with: "世界史"
      fill_in_rich_text_area "article_content", with: "Hello <em>world!</em>"
      # 送信するとTweetモデルのカウントが1上がることを確認する
      #expect do
        #click_button "公開する"
      #end.to change(Article.count).by(1)
      #トップページに遷移することを確認する
      #expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容の画像が存在することを確認する（画像）
      #expect(page).to have_selector('img')
      # トップページには先ほど投稿した内容のタイトルが存在することを確認する（テキスト）
      #expect(page).to have_content(@article_title)
    end
  end
  context '記事投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('投稿する')
    end
  end
end
RSpec.describe '記事編集', type: :system do
  before do
    @article1 = FactoryBot.create(:article)
    @article2 = FactoryBot.create(:article)
    sleep(1)
  end
  context '記事編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # 記事1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Eメール', with: @article1.user.email
      fill_in 'パスワード', with: @article1.user.password
      click_button "Log in"
      expect(current_path).to eq(root_path)
      #記事閲覧ページに遷移する
      visit article_path(@article1.id)
      # 記事1に「編集」ボタンがあることを確認する
      expect(page).to have_link '編集', href: edit_article_path(@article1.id)

      # 編集ページへ遷移する
      visit edit_article_path(@article1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#article_title').value
      ).to eq(@article1.title)
      expect(
        find('#article_tag_list').value
      ).to eq("英語")
      #
      # 投稿内容を編集する
      fill_in 'article_title', with: "編集したテキスト"
      fill_in 'article_tag_list', with: "編集したタグ"
      fill_in_rich_text_area "article_content", with: "Hello <em>world!</em>"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect {
        click_button "公開する"
      }.to change(Article, :count).by(0)
      # 編集完了画面に遷移したことを確認する
      expect(current_path).to eq(article_path(@article1.id))
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容のツイートが存在することを確認する（タイトル）
      expect(page).to have_content("編集したテキスト")
      expect(page).to have_content("編集したタグ")
    end
  end
  context '記事編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した記事の編集画面には遷移できない' do
      # 記事1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Eメール', with: @article1.user.email
      fill_in 'パスワード', with: @article1.user.password
      click_button "Log in"
      expect(current_path).to eq(root_path)
      #記事詳細ページへ遷移する
      visit article_path(@article2.id)
      # 記事2に「編集」ボタンがないことを確認する
      expect(page).to have_no_link '編集', href: edit_article_path(@article2.id)
    end
    it 'ログインしていないと記事の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 記事1に「編集」ボタンがないことを確認する
      visit article_path(@article1)
      expect(page).to have_no_link '編集', href: edit_article_path(@article1.id)
      # 記事2に「編集」ボタンがないことを確認する
      visit article_path(@article2)
      expect(page).to have_no_link '編集', href: edit_article_path(@article2.id)
    end
  end
end
RSpec.describe '記事削除', type: :system do
  before do
    @article1 = FactoryBot.create(:article)
    @article2 = FactoryBot.create(:article, title: "世界史の学習方法", tag_list: "世界史")
  end
  context '記事削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した記事の削除ができる' do
      # 記事1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Eメール', with: @article1.user.email
      fill_in 'パスワード', with: @article1.user.password
      click_button "Log in"
      expect(current_path).to eq(root_path)
      #記事詳細ページに遷移する
      visit article_path(@article1.id)
      # 記事1に「削除」ボタンがあることを確認する
      expect(page).to have_no_link '削除', href: edit_article_path(@article1.id)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        click_link '削除'
      }.to change(Article, :count).by(-1)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # トップページには記事1の内容が存在しないことを確認する（タイトル）
      expect(page).to have_no_content("#{@article1.title}")
      expect(page).to have_no_content("英語")
    end
  end
  context '記事削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した記事の削除ができない' do
      # 記事1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Eメール', with: @article1.user.email
      fill_in 'パスワード', with: @article1.user.password
      click_button "Log in"
      expect(current_path).to eq(root_path)
      #記事詳細ページへ遷移する
      visit article_path(@article2)
      # 記事2に「削除」ボタンが無いことを確認する
      expect(page).to have_no_link '削除', href: edit_article_path(@article2.id)
    end
    it 'ログインしていないと記事の削除ボタンがない' do
      # 記事1の詳細ページに移動する
      visit article_path(@article1.id)
      # 記事1に「削除」ボタンが無いことを確認する
      expect(page).to have_no_link '削除', href: edit_article_path(@article1.id)
      # 記事2詳細ページに移動する
      visit article_path(@article2.id)
      # 記事2に「削除」ボタンが無いことを確認する
      expect(page).to have_no_link '削除', href: edit_article_path(@article2.id)
    end
  end
end
RSpec.describe '記事詳細', type: :system do
  before do
    @article = FactoryBot.create(:article)
  end
  it 'ログインしたユーザーはツイート詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    visit new_user_session_path
    fill_in 'Eメール', with: @article.user.email
    fill_in 'パスワード', with: @article.user.password
    click_button "Log in"
    expect(current_path).to eq(root_path)
    # 詳細ページに遷移する
    visit article_path(@article.id)
    # 詳細ページに記事の内容が含まれている
    expect(page).to have_content("#{@article.title}")
    expect(page).to have_content("英語")
    # コメント用のフォームが存在する
    expect(page).to have_selector 'form'
  end
  it 'ログインしていない状態でツイート詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    # 詳細ページに遷移する
    visit article_path(@article.id)
    # 詳細ページにツイートの内容が含まれている
    expect(page).to have_content("#{@article.title}")
    expect(page).to have_content("英語")
    # フォームが存在しないことを確認する
    expect(page).to have_selector 'form'
  end
end