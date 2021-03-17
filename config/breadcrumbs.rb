crumb :root do
  link "トップページ", root_path
end

crumb :user do |user|
  user = User.find(params[:id])
  link user.nickname, user_path(user)
  parent :root
end


crumb :user_activity do 
  link "あなたの履歴", activities_path
  parent :root
end

crumb :following_user do |user|
  user = User.find(params[:id])
  link "フォロー", followings_user_path
  parent :user, user
end

crumb :followers_user do |user|
  user = User.find(params[:id])
  link "フォロワー", followers_user_path
  parent :user, user
end

crumb :article do |article|
  article = Article.find(params[:id])
  link "#{article.user.nickname}さんの投稿記事", article_path(article)
  parent :root
end

crumb :notification do
  link "通知一覧", notifications_path
  parent :root
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).