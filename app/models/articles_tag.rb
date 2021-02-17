class ArticlesTag

  include ActiveModel::Model
  attr_accessor :title, :name, :content, :user_id

  with_options presence: true do
    validates :title
    validates :name
    validates :content
    validates :user_id
  end

  def save
    article = Article.create(title: title, content: content, user_id: user_id)
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    ArticleTagRelation.create(article_id: article.id, tag_id: tag.id)
  end

end